using DelphiVisualizer.Models;

namespace DelphiVisualizer.Parser;

public static class DependencyResolver
{
    private enum Color { White, Gray, Black }

    private record StackFrame(string UnitName, string? Parent, string EdgeKind, bool IsExit, int Depth);

    public static DependencyGraph Resolve(
        string rootUnitName,
        Dictionary<string, ProjectUnit> projectUnits,
        int maxDepth = int.MaxValue,
        IProgress<(int done, int total)>? progress = null)
    {
        var graph = new DependencyGraph { RootUnit = rootUnitName };
        var colors = new Dictionary<string, Color>(StringComparer.OrdinalIgnoreCase);
        var grayStack = new Stack<string>();
        var edgeSet = new HashSet<string>();

        // Parse all project units (cached on ProjectUnit after first call).
        // This disk-bound loop dominates the runtime on large projects, so it
        // drives the loading progress bar.
        var pending = projectUnits.Values.Where(u => u.FileFound).ToList();
        int total = pending.Count, done = 0;
        progress?.Report((0, total));

        foreach (var unit in pending)
        {
            if (unit.InterfaceUses.Count == 0 && unit.ImplementationUses.Count == 0)
            {
                var (ifaceUses, implUses) = PasParser.Parse(unit.AbsolutePath);
                unit.InterfaceUses = ifaceUses;
                unit.ImplementationUses = implUses;
            }
            graph.Units[unit.Name] = unit;

            if (++done % 25 == 0 || done == total)
                progress?.Report((done, total));
        }

        if (!projectUnits.TryGetValue(rootUnitName, out var rootUnit))
            return graph;

        // Use the canonical spelling of the root so edges/nodes match regardless
        // of how the caller (or a uses clause) cased the name.
        rootUnitName = rootUnit.Name;
        graph.RootUnit = rootUnitName;

        // Shortest distance from the root. The DFS below decides expansion by
        // this value rather than by the depth at which it happens to reach a
        // unit first, so the depth limit no longer depends on uses-clause order.
        var minDepth = ComputeMinDepths(rootUnitName, projectUnits);

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

            if (!projectUnits.TryGetValue(frame.UnitName, out var unit) || !unit.FileFound)
                continue;  // skip stdlib/external units (no .pas in project)

            // Canonical name: Delphi is case-insensitive, so "sysutils" and
            // "SysUtils" must yield the same node id in edges and cycles.
            var name = unit.Name;

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

            // Stop expanding at maxDepth (measured as shortest distance from root)
            if (minDepth.GetValueOrDefault(name, int.MaxValue) >= maxDepth) continue;

            foreach (var dep in unit.ImplementationUses.AsEnumerable().Reverse())
                stack.Push(new StackFrame(dep, name, "implementation", false, frame.Depth + 1));

            foreach (var dep in unit.InterfaceUses.AsEnumerable().Reverse())
                stack.Push(new StackFrame(dep, name, "interface", false, frame.Depth + 1));
        }

        return graph;
    }

    private static Dictionary<string, int> ComputeMinDepths(
        string rootName, Dictionary<string, ProjectUnit> projectUnits)
    {
        var depth = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase) { [rootName] = 0 };
        var queue = new Queue<string>();
        queue.Enqueue(rootName);

        while (queue.Count > 0)
        {
            var current = queue.Dequeue();
            var d = depth[current];
            var unit = projectUnits[current];

            foreach (var dep in unit.InterfaceUses.Concat(unit.ImplementationUses))
            {
                if (!projectUnits.TryGetValue(dep, out var depUnit) || !depUnit.FileFound) continue;
                if (depth.ContainsKey(depUnit.Name)) continue;
                depth[depUnit.Name] = d + 1;
                queue.Enqueue(depUnit.Name);
            }
        }
        return depth;
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
