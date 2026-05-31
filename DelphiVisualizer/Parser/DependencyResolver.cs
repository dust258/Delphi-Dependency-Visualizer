using DelphiVisualizer.Models;

namespace DelphiVisualizer.Parser;

public static class DependencyResolver
{
    private enum Color { White, Gray, Black }

    private record StackFrame(string UnitName, string? Parent, string EdgeKind, bool IsExit, int Depth);

    public static DependencyGraph Resolve(
        string rootUnitName,
        Dictionary<string, ProjectUnit> projectUnits,
        int maxDepth = int.MaxValue)
    {
        var graph = new DependencyGraph { RootUnit = rootUnitName };
        var colors = new Dictionary<string, Color>(StringComparer.OrdinalIgnoreCase);
        var grayStack = new Stack<string>();
        var edgeSet = new HashSet<string>();

        // Parse all project units (cached on ProjectUnit after first call)
        foreach (var unit in projectUnits.Values)
        {
            if (!unit.FileFound) continue;
            if (unit.InterfaceUses.Count == 0 && unit.ImplementationUses.Count == 0)
            {
                var (ifaceUses, implUses) = PasParser.Parse(unit.AbsolutePath);
                unit.InterfaceUses = ifaceUses;
                unit.ImplementationUses = implUses;
            }
            graph.Units[unit.Name] = unit;
        }

        if (!projectUnits.ContainsKey(rootUnitName))
            return graph;

        var stack = new Stack<StackFrame>();
        stack.Push(new StackFrame(rootUnitName, null, "interface", false, 0));

        while (stack.Count > 0)
        {
            var frame = stack.Pop();

            if (frame.IsExit)
            {
                colors[frame.UnitName] = Color.Black;
                if (grayStack.Count > 0 && grayStack.Peek() == frame.UnitName)
                    grayStack.Pop();
                continue;
            }

            var name = frame.UnitName;

            if (!projectUnits.TryGetValue(name, out var unit) || !unit.FileFound)
                continue;  // skip stdlib/external units (no .pas in project)

            colors.TryGetValue(name, out var color);

            if (color == Color.Gray)
            {
                if (frame.Parent != null)
                    AddEdge(graph, edgeSet, frame.Parent, name, frame.EdgeKind, true);

                var cycle = ExtractCyclePath(grayStack, name);
                if (cycle.Count > 1 && !graph.Cycles.Any(c => CycleEquals(c, cycle)))
                    graph.Cycles.Add(cycle);
                continue;
            }

            if (color == Color.Black)
            {
                if (frame.Parent != null)
                    AddEdge(graph, edgeSet, frame.Parent, name, frame.EdgeKind, false);
                continue;
            }

            // White: first visit
            colors[name] = Color.Gray;
            grayStack.Push(name);

            if (frame.Parent != null)
                AddEdge(graph, edgeSet, frame.Parent, name, frame.EdgeKind, false);

            stack.Push(new StackFrame(name, null, "", true, frame.Depth));

            // Stop expanding beyond maxDepth
            if (frame.Depth >= maxDepth) continue;

            foreach (var dep in unit.ImplementationUses.AsEnumerable().Reverse())
                stack.Push(new StackFrame(dep, name, "implementation", false, frame.Depth + 1));

            foreach (var dep in unit.InterfaceUses.AsEnumerable().Reverse())
                stack.Push(new StackFrame(dep, name, "interface", false, frame.Depth + 1));
        }

        return graph;
    }

    private static void AddEdge(DependencyGraph graph, HashSet<string> edgeSet,
        string source, string target, string kind, bool isCyclic)
    {
        var key = $"{source}|{target}|{kind}";
        if (!edgeSet.Add(key)) return;

        graph.Edges.Add(new DependencyEdge
        {
            Source = source,
            Target = target,
            Kind = kind,
            IsCyclic = isCyclic
        });
    }

    private static List<string> ExtractCyclePath(Stack<string> grayStack, string cycleTarget)
    {
        var path = new List<string>(grayStack);
        path.Reverse();
        var idx = path.FindIndex(s => s.Equals(cycleTarget, StringComparison.OrdinalIgnoreCase));
        if (idx < 0) return path;
        var cycle = path[idx..];
        cycle.Add(cycleTarget);
        return cycle;
    }

    private static bool CycleEquals(List<string> a, List<string> b)
    {
        if (a.Count != b.Count) return false;
        return a.Zip(b).All(p => p.First.Equals(p.Second, StringComparison.OrdinalIgnoreCase));
    }
}
