using DelphiVisualizer.Services;
using System.IO;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace DelphiVisualizer;

// MCP control surface (see Services/McpServer.cs). Everything here runs on the
// UI thread; the server marshals calls through the Dispatcher.
public partial class MainWindow
{
    private McpServer? _mcp;
    private string? _lastError;
    private string _layoutMode = "force";

    private readonly Queue<string> _logBuffer = new();
    private readonly object _logLock = new();

    private static readonly JsonSerializerOptions Pretty = new() { WriteIndented = true };

    private void AddLog(string line)
    {
        lock (_logLock)
        {
            _logBuffer.Enqueue(line);
            while (_logBuffer.Count > 1000) _logBuffer.Dequeue();
        }
    }

    public void StartMcp(int port)
    {
        try
        {
            _mcp = new McpServer(this, port);
            _mcp.Start();
            Closed += (_, _) => _mcp?.Dispose();
            AddLog($"[{DateTime.Now:HH:mm:ss.fff}] MCP server listening on http://127.0.0.1:{port}/mcp");
        }
        catch (Exception ex)
        {
            _mcp = null;
            AddLog($"[{DateTime.Now:HH:mm:ss.fff}] MCP server failed to start: {ex.Message}");
        }
    }

    // ── Dispatcher for tool calls ────────────────────────────

    public async Task<JsonArray> McpCall(string name, JsonObject args)
    {
        switch (name)
        {
            case "get_state":
                return Text(BuildState());

            case "open_project":
            {
                var path = Str(args, "path") ?? throw new ArgumentException("'path' is required");
                if (!File.Exists(path)) throw new FileNotFoundException("File not found: " + path);
                await WaitWebViewReady();
                _lastError = null;
                LoadProject(path, Str(args, "unit"));
                if (_lastError != null) throw new InvalidOperationException(_lastError);
                if (Bool(args, "analyze") ?? true)
                    if (BtnAnalyze.IsEnabled && !string.IsNullOrEmpty(_selectedUnit))
                        await AnalyzeAndReport(_selectedUnit);
                return Text(BuildState());
            }

            case "list_units":
            {
                var filter = Str(args, "filter");
                var type = Str(args, "type");
                var limit = Int(args, "limit") ?? 100;
                var all = _projectUnits.Values.Where(u => u.FileFound)
                    .Where(u => string.IsNullOrEmpty(filter) || u.Name.Contains(filter, StringComparison.OrdinalIgnoreCase))
                    .Where(u => string.IsNullOrEmpty(type) || u.UnitType.Equals(type, StringComparison.OrdinalIgnoreCase))
                    .OrderBy(u => u.Name, StringComparer.OrdinalIgnoreCase)
                    .ToList();
                return Text(Json(new
                {
                    total = all.Count,
                    units = all.Take(limit).Select(u => new { u.Name, u.UnitType, u.FilePath })
                }));
            }

            case "analyze":
            {
                var unit = Str(args, "unit") ?? _selectedUnit;
                if (string.IsNullOrEmpty(unit)) throw new InvalidOperationException("No unit given and none selected — load a project first.");
                if (!_projectUnits.TryGetValue(unit, out var u) || !u.FileFound)
                    throw new ArgumentException($"Unknown unit '{unit}' (see list_units)");
                if (Int(args, "depth") is int d) SlDepth.Value = Math.Clamp(d, 1, 10);
                await WaitWebViewReady();
                await AnalyzeAndReport(u.Name);
                return Text(BuildState());
            }

            case "get_graph":
                return Text(BuildGraphInfo(Str(args, "include") ?? "summary", Int(args, "limit") ?? 50));

            case "set_layout":
            {
                var mode = Str(args, "mode")?.ToLowerInvariant();
                switch (mode)
                {
                    case "layered": BtnLayered_Click(this, null!); break;
                    case "force": BtnForce_Click(this, null!); break;
                    case "tree": BtnTree_Click(this, null!); break;
                    case "radial": BtnRadial_Click(this, null!); break;
                    default: throw new ArgumentException("mode must be layered | force | tree | radial");
                }
                return Text($"layout = {mode}");
            }

            case "set_filter":
                _suppressFilterChanged = true;
                if (Bool(args, "formsOnly") is bool f) CbFormsOnly.IsChecked = f;
                if (Bool(args, "sameDir") is bool s) CbDirFilter.IsChecked = s;
                if (Bool(args, "usesFiltered") is bool uf) CbUsesFiltered.IsChecked = uf;
                _suppressFilterChanged = false;
                SendVisFilter();
                return Text(BuildState());

            case "select_unit":
            {
                var unit = Str(args, "unit") ?? throw new ArgumentException("'unit' is required");
                RequireWebView();
                await WebView.ExecuteScriptAsync($"highlightNode({JsonSerializer.Serialize(unit)})");
                return Text("selected " + unit);
            }

            case "reset_camera":
                RequireWebView();
                await WebView.ExecuteScriptAsync("resetCamera()");
                return Text("ok");

            case "screenshot":
            {
                RequireWebView();
                using var ms = new MemoryStream();
                await WebView.CoreWebView2.CapturePreviewAsync(
                    Microsoft.Web.WebView2.Core.CoreWebView2CapturePreviewImageFormat.Png, ms);
                return new JsonArray(new JsonObject
                {
                    ["type"] = "image",
                    ["data"] = Convert.ToBase64String(ms.ToArray()),
                    ["mimeType"] = "image/png"
                });
            }

            case "eval_js":
            {
                var script = Str(args, "script") ?? throw new ArgumentException("'script' is required");
                RequireWebView();
                var param = JsonSerializer.Serialize(new
                {
                    expression = script,
                    returnByValue = true,
                    awaitPromise = true,
                    userGesture = true
                });
                var raw = await WebView.CoreWebView2.CallDevToolsProtocolMethodAsync("Runtime.evaluate", param);
                var node = JsonNode.Parse(raw)!;
                if (node["exceptionDetails"] is JsonNode ex)
                    throw new InvalidOperationException("JS exception: " +
                        (ex["exception"]?["description"] ?? ex["text"])?.ToString());
                var value = node["result"]?["value"];
                return Text(value == null
                    ? (node["result"]?["description"]?.ToString() ?? node["result"]?["type"]?.ToString() ?? "undefined")
                    : value is JsonValue jv && jv.TryGetValue<string>(out var str) ? str
                    : value.ToJsonString(Pretty));
            }

            case "get_log":
            {
                var n = Int(args, "lines") ?? 100;
                string[] lines;
                lock (_logLock)
                {
                    lines = _logBuffer.TakeLast(n).ToArray();
                    if (Bool(args, "clear") == true) _logBuffer.Clear();
                }
                return Text(lines.Length == 0 ? "(no log lines)" : string.Join("\n", lines));
            }

            default:
                throw new ArgumentException("Unknown tool: " + name);
        }
    }

    // ── Helpers ──────────────────────────────────────────────

    private async Task AnalyzeAndReport(string unit)
    {
        SelectUnit(unit);
        BtnAnalyze.IsEnabled = true;
        _lastError = null;
        await AnalyzeDependencies(unit);
        if (_lastError != null) throw new InvalidOperationException("Analysis failed: " + _lastError);
        await Task.Delay(400); // let loadGraph() in the WebView run
    }

    private async Task WaitWebViewReady()
    {
        for (int i = 0; i < 300 && !_webViewReady; i++)
            await Task.Delay(100);
        RequireWebView();
    }

    private void RequireWebView()
    {
        if (!_webViewReady) throw new InvalidOperationException("WebView is not ready yet.");
    }

    private string BuildState() => Json(new
    {
        projectPath = _currentProjectPath,
        unitCount = _projectUnits.Values.Count(u => u.FileFound),
        selectedUnit = _selectedUnit,
        depth = (int)SlDepth.Value >= 10 ? "unlimited" : ((int)SlDepth.Value).ToString(),
        layout = _layoutMode,
        filters = new
        {
            formsOnly = CbFormsOnly.IsChecked == true,
            sameDir = CbDirFilter.IsChecked == true,
            usesFiltered = CbUsesFiltered.IsChecked == true
        },
        webViewReady = _webViewReady,
        analyzing = _analyzing,
        fullscreen = _isFullscreen,
        graph = _currentGraph == null ? null : new
        {
            root = _currentGraph.RootUnit,
            units = _currentGraph.Units.Count,
            edges = _currentGraph.Edges.Count,
            cycles = _currentGraph.Cycles.Count
        },
        status = TbStatus.Text,
        title = Title,
        lastError = _lastError
    });

    private string BuildGraphInfo(string include, int limit)
    {
        var g = _currentGraph ?? throw new InvalidOperationException("No graph yet — call analyze first.");

        var incoming = g.Edges.GroupBy(e => e.Target, StringComparer.OrdinalIgnoreCase)
            .Select(x => new { unit = x.Key, count = x.Count() })
            .OrderByDescending(x => x.count).Take(limit).ToList();
        var outgoing = g.Edges.GroupBy(e => e.Source, StringComparer.OrdinalIgnoreCase)
            .Select(x => new { unit = x.Key, count = x.Count() })
            .OrderByDescending(x => x.count).Take(limit).ToList();

        return Json(new
        {
            root = g.RootUnit,
            units = g.Units.Count,
            edges = g.Edges.Count,
            cyclicEdges = g.Edges.Count(e => e.IsCyclic),
            cycleCount = g.Cycles.Count,
            cycles = g.Cycles.Take(limit).Select(c => string.Join(" -> ", c)),
            mostUsed = incoming,
            mostUses = outgoing,
            edgeList = include == "edges"
                ? g.Edges.Take(limit).Select(e => new { e.Source, e.Target, e.Kind, e.IsCyclic })
                : null
        });
    }

    private static JsonArray Text(string s) =>
        new(new JsonObject { ["type"] = "text", ["text"] = s });

    private static string Json(object o) => JsonSerializer.Serialize(o, Pretty);

    private static string? Str(JsonObject a, string k) =>
        a[k] is JsonValue v && v.TryGetValue<string>(out var s) && !string.IsNullOrEmpty(s) ? s : null;

    private static int? Int(JsonObject a, string k) =>
        a[k] is JsonValue v && v.TryGetValue<int>(out var i) ? i : null;

    private static bool? Bool(JsonObject a, string k) =>
        a[k] is JsonValue v && v.TryGetValue<bool>(out var b) ? b : null;
}
