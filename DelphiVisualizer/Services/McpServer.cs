using System.IO;
using System.Net;
using System.Text;
using System.Text.Json.Nodes;

namespace DelphiVisualizer.Services;

// Minimal MCP server (Streamable HTTP, JSON responses only) that lets an AI
// assistant drive and debug the running app. Opt-in (--mcp / DELPHIVIZ_MCP),
// bound to 127.0.0.1 only. The tools themselves live in MainWindow.Mcp.cs.
public sealed class McpServer : IDisposable
{
    public const int DefaultPort = 39217;
    private const string ProtocolVersion = "2025-03-26";

    private readonly MainWindow _win;
    private readonly HttpListener _listener = new();
    private readonly CancellationTokenSource _cts = new();

    public int Port { get; }

    public McpServer(MainWindow win, int port)
    {
        _win = win;
        Port = port;
        _listener.Prefixes.Add($"http://127.0.0.1:{port}/");
    }

    public void Start()
    {
        _listener.Start();
        _ = Task.Run(AcceptLoop);
    }

    public void Dispose()
    {
        _cts.Cancel();
        try { _listener.Close(); } catch { }
    }

    private async Task AcceptLoop()
    {
        while (!_cts.IsCancellationRequested && _listener.IsListening)
        {
            HttpListenerContext ctx;
            try { ctx = await _listener.GetContextAsync(); }
            catch { break; }
            _ = Task.Run(() => Handle(ctx));
        }
    }

    private async Task Handle(HttpListenerContext ctx)
    {
        var res = ctx.Response;
        try
        {
            var path = ctx.Request.Url?.AbsolutePath.TrimEnd('/') ?? "";
            if (path != "/mcp") { await Reply(res, 404, null); return; }

            // Block browser-originated requests (DNS rebinding / CSRF against localhost).
            var origin = ctx.Request.Headers["Origin"];
            if (!string.IsNullOrEmpty(origin) &&
                !(Uri.TryCreate(origin, UriKind.Absolute, out var o) && o.IsLoopback))
            { await Reply(res, 403, null); return; }

            if (ctx.Request.HttpMethod != "POST") { await Reply(res, 405, null); return; }

            string body;
            using (var reader = new StreamReader(ctx.Request.InputStream, Encoding.UTF8))
                body = await reader.ReadToEndAsync();

            JsonNode? parsed;
            try { parsed = JsonNode.Parse(body); }
            catch { await Reply(res, 400, Error(null, -32700, "Parse error").ToJsonString()); return; }

            string? json;
            if (parsed is JsonArray batch)
            {
                var results = new JsonArray();
                foreach (var item in batch.OfType<JsonObject>())
                {
                    var r = await Process(item);
                    if (r != null) results.Add(r);
                }
                json = results.Count > 0 ? results.ToJsonString() : null;
            }
            else if (parsed is JsonObject obj)
                json = (await Process(obj))?.ToJsonString();
            else
            { await Reply(res, 400, Error(null, -32600, "Invalid Request").ToJsonString()); return; }

            await Reply(res, json == null ? 202 : 200, json);
        }
        catch
        {
            try { await Reply(res, 500, null); } catch { }
        }
    }

    private static async Task Reply(HttpListenerResponse res, int status, string? json)
    {
        res.StatusCode = status;
        if (json != null)
        {
            var bytes = Encoding.UTF8.GetBytes(json);
            res.ContentType = "application/json";
            res.ContentLength64 = bytes.Length;
            await res.OutputStream.WriteAsync(bytes);
        }
        res.Close();
    }

    private async Task<JsonObject?> Process(JsonObject req)
    {
        var id = req["id"]?.DeepClone();
        var method = req["method"]?.GetValue<string>();
        if (id == null) return null; // notification (e.g. notifications/initialized)

        try
        {
            switch (method)
            {
                case "initialize":
                    return Result(id, new JsonObject
                    {
                        ["protocolVersion"] = req["params"]?["protocolVersion"]?.GetValue<string>() ?? ProtocolVersion,
                        ["capabilities"] = new JsonObject { ["tools"] = new JsonObject() },
                        ["serverInfo"] = new JsonObject { ["name"] = "delphi-visualizer", ["version"] = "1.0" }
                    });
                case "ping":
                    return Result(id, new JsonObject());
                case "tools/list":
                    return Result(id, new JsonObject { ["tools"] = ToolList() });
                case "tools/call":
                {
                    var name = req["params"]?["name"]?.GetValue<string>() ?? "";
                    var args = req["params"]?["arguments"] as JsonObject ?? new JsonObject();
                    try
                    {
                        // Everything touching WPF/WebView2 runs on the UI thread.
                        var content = await await _win.Dispatcher.InvokeAsync(() => _win.McpCall(name, args));
                        return Result(id, new JsonObject { ["content"] = content, ["isError"] = false });
                    }
                    catch (Exception ex)
                    {
                        return Result(id, new JsonObject
                        {
                            ["content"] = new JsonArray(new JsonObject { ["type"] = "text", ["text"] = ex.Message }),
                            ["isError"] = true
                        });
                    }
                }
                default:
                    return Error(id, -32601, $"Method not found: {method}");
            }
        }
        catch (Exception ex)
        {
            return Error(id, -32603, ex.Message);
        }
    }

    private static JsonObject Result(JsonNode id, JsonObject result) =>
        new() { ["jsonrpc"] = "2.0", ["id"] = id, ["result"] = result };

    private static JsonObject Error(JsonNode? id, int code, string message) =>
        new()
        {
            ["jsonrpc"] = "2.0",
            ["id"] = id,
            ["error"] = new JsonObject { ["code"] = code, ["message"] = message }
        };

    // ── Tool catalogue ───────────────────────────────────────

    private static JsonObject Tool(string name, string description, JsonObject? props = null, params string[] required)
    {
        var schema = new JsonObject { ["type"] = "object", ["properties"] = props ?? new JsonObject() };
        if (required.Length > 0)
            schema["required"] = new JsonArray(required.Select(r => (JsonNode)r).ToArray());
        return new JsonObject { ["name"] = name, ["description"] = description, ["inputSchema"] = schema };
    }

    private static JsonObject Prop(string type, string description) =>
        new() { ["type"] = type, ["description"] = description };

    private static JsonArray ToolList() => new(
        Tool("get_state",
            "Current app state: loaded project, selected unit, depth, layout, filters, graph size, status text, last error."),
        Tool("open_project",
            "Load a .dpr, .gv or .dot file and (by default) analyse it right away.",
            new JsonObject
            {
                ["path"] = Prop("string", "Absolute path of the project file"),
                ["unit"] = Prop("string", "Start unit (default: first unit or last used)"),
                ["analyze"] = Prop("boolean", "Run the analysis after loading (default true)")
            }, "path"),
        Tool("list_units",
            "List the units of the loaded project (only units with a resolved file).",
            new JsonObject
            {
                ["filter"] = Prop("string", "Case-insensitive substring of the unit name"),
                ["type"] = Prop("string", "Unit | Form | DataModule | Frame | Program"),
                ["limit"] = Prop("integer", "Max results (default 100)")
            }),
        Tool("analyze",
            "Analyse dependencies from a start unit and render the graph. Waits until finished.",
            new JsonObject
            {
                ["unit"] = Prop("string", "Start unit (default: currently selected unit)"),
                ["depth"] = Prop("integer", "1-9 = depth limit, 10 = unlimited (default: current slider value)")
            }),
        Tool("get_graph",
            "Inspect the current graph: counts, cycles, units with most incoming/outgoing edges, optionally the edge list.",
            new JsonObject
            {
                ["include"] = Prop("string", "summary (default) | edges"),
                ["limit"] = Prop("integer", "Max list entries (default 50)")
            }),
        Tool("set_layout", "Switch the layout mode.",
            new JsonObject { ["mode"] = Prop("string", "layered | force | tree | radial") }, "mode"),
        Tool("set_filter", "Set the graph visibility filters (omitted values keep their current state).",
            new JsonObject
            {
                ["formsOnly"] = Prop("boolean", "Show forms only"),
                ["sameDir"] = Prop("boolean", "Only units in the start unit's directory"),
                ["usesFiltered"] = Prop("boolean", "Only units that use other visible units")
            }),
        Tool("select_unit", "Highlight a unit in the graph (as a click on it would).",
            new JsonObject { ["unit"] = Prop("string", "Unit name") }, "unit"),
        Tool("reset_camera", "Zoom the 3D view to fit the whole graph."),
        Tool("screenshot", "Screenshot of the 3D view (WebView) as PNG."),
        Tool("eval_js",
            "Evaluate JavaScript in the WebView (DevTools Runtime.evaluate, awaits promises, returns value or exception). For debugging.",
            new JsonObject { ["script"] = Prop("string", "JavaScript expression/statements") }, "script"),
        Tool("get_log",
            "Recent log lines: app.js log() output, JS errors/unhandled rejections/console.error, MCP/analysis errors.",
            new JsonObject
            {
                ["lines"] = Prop("integer", "Number of most recent lines (default 100)"),
                ["clear"] = Prop("boolean", "Clear the buffer after reading")
            }));
}
