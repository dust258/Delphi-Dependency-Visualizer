using DelphiVisualizer.Models;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DelphiVisualizer.Graph;

public static class GraphBuilder
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        DefaultIgnoreCondition = JsonIgnoreCondition.Never
    };

    public static string BuildJson(DependencyGraph graph)
    {
        // Count incoming edges per node (for sizing)
        var incomingCount = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        foreach (var edge in graph.Edges)
        {
            if (incomingCount.TryGetValue(edge.Target, out var count))
                incomingCount[edge.Target] = count + 1;
            else
                incomingCount[edge.Target] = 1;
        }

        // Collect all node names that appear in the graph
        var nodeNames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        nodeNames.Add(graph.RootUnit);
        foreach (var edge in graph.Edges)
        {
            nodeNames.Add(edge.Source);
            nodeNames.Add(edge.Target);
        }

        // Color heat = how many units THIS unit directly uses (outgoing uses-clause entries)
        var directUses = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        foreach (var edge in graph.Edges.Where(e => e.Kind == "interface" || e.Kind == "implementation"))
        {
            directUses.TryGetValue(edge.Source, out var c);
            directUses[edge.Source] = c + 1;
        }
        var sortedHeats = directUses.Values.OrderBy(x => x).ToList();
        // Cap at 90th percentile so outliers don't compress the rest; square curve → gray dominant
        var capIdx = Math.Min((int)(sortedHeats.Count * 0.9), sortedHeats.Count - 1);
        var heatCap = Math.Max(1, sortedHeats.Count > 0 ? sortedHeats[capIdx] : 1);

        // Build nodes array
        var nodes = new List<object>();
        foreach (var name in nodeNames)
        {
            graph.Units.TryGetValue(name, out var unit);
            var unitType = unit?.UnitType ?? "Unit";

            var isRoot = name.Equals(graph.RootUnit, StringComparison.OrdinalIgnoreCase);
            incomingCount.TryGetValue(name, out var incoming);
            var baseVal = incoming > 0 ? (int)(Math.Log(incoming + 1, 2) * 2) + 1 : 1;
            var val = isRoot ? baseVal * 125 : baseVal;

            var rawHeat = directUses.GetValueOrDefault(name, 0);
            var tLinear = Math.Min(1.0, rawHeat / (double)heatCap);
            var t = tLinear * tLinear; // square curve: low values stay gray, only high values turn red
            var color = HeatColor(t);

            var filePath = unit?.FilePath ?? "";
            nodes.Add(new
            {
                id = name,
                name,
                unitType,
                val,
                color,
                isRoot,
                fileFound = unit?.FileFound ?? false,
                filePath,
                dir = ExtractDir(filePath)
            });
        }

        // Build links array
        var links = new List<object>();
        foreach (var edge in graph.Edges)
        {
            links.Add(new
            {
                source = edge.Source,
                target = edge.Target,
                kind = edge.Kind,
                isCyclic = edge.IsCyclic,
                color = edge.IsCyclic ? "#FF5252" : (edge.Kind == "interface" ? "#64B5F6" : "#78909C"),
                width = edge.IsCyclic ? 3 : 1
            });
        }

        var data = new
        {
            nodes,
            links,
            cycles = graph.Cycles,
            rootUnit = graph.RootUnit,
            stats = new
            {
                unitCount = nodeNames.Count,
                edgeCount = graph.Edges.Count,
                cycleCount = graph.Cycles.Count
            }
        };

        return JsonSerializer.Serialize(data, JsonOptions);
    }

    // Normalized directory of a unit's .pas file (forward slashes, no filename).
    // Used by the 3D tree layout to cluster units from the same module/folder.
    private static string ExtractDir(string filePath)
    {
        if (string.IsNullOrEmpty(filePath)) return "(root)";
        var p = filePath.Replace('\\', '/');
        var idx = p.LastIndexOf('/');
        if (idx < 0) return "(root)";
        return p[..idx].TrimStart('.', '/');
    }

    // Linear gradient: gray (#607080) → red (#FF1400)
    private static string HeatColor(double t)
    {
        var r = (int)(96  + t * (255 - 96));
        var g = (int)(112 + t * (20  - 112));
        var b = (int)(128 + t * (0   - 128));
        return $"#{r:X2}{g:X2}{b:X2}";
    }
}
