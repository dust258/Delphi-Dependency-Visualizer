using DelphiVisualizer.Models;
using System.IO;
using System.Text.RegularExpressions;

namespace DelphiVisualizer.Parser;

// Imports the .gv (DOT) file produced by the Delphi 12+ compiler's --graphviz
// switch. The compiler already resolved every uses-clause, so this sidesteps
// the search-path/FileFound guessing DprParser + PasParser do on disk.
public static class GraphVizParser
{
    private static readonly Regex HeaderRegex =
        new(@"(?:strict\s+)?digraph\s+(\w+)\s*\{", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private static readonly Regex GroupedEdgeRegex =
        new(@"(\w+)\s*->\s*\{([^}]*)\}", RegexOptions.Compiled);

    private static readonly Regex SimpleEdgeRegex =
        new(@"(\w+)\s*->\s*(\w+)\s*(\[[^\]]*\])?", RegexOptions.Compiled);

    public static Dictionary<string, ProjectUnit> Parse(string gvPath)
    {
        var units = new Dictionary<string, ProjectUnit>(StringComparer.OrdinalIgnoreCase);
        var content = File.ReadAllText(gvPath);
        var stripped = StripComments(content);

        var headerMatch = HeaderRegex.Match(stripped);
        var programName = headerMatch.Success ? headerMatch.Groups[1].Value : null;

        // Grouped form: "Program -> { UnitA UnitB UnitC }" — remove these spans
        // once consumed so the simple-edge regex doesn't also match inside them.
        var remaining = stripped;
        foreach (Match m in GroupedEdgeRegex.Matches(stripped))
        {
            var source = m.Groups[1].Value;
            foreach (var target in m.Groups[2].Value.Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries))
                AddEdge(units, source, target, "interface");

            remaining = remaining.Replace(m.Value, "");
        }

        foreach (Match m in SimpleEdgeRegex.Matches(remaining))
        {
            var source = m.Groups[1].Value;
            var target = m.Groups[2].Value;
            var attrs = m.Groups[3].Success ? m.Groups[3].Value : "";
            var kind = attrs.Contains("dashed", StringComparison.OrdinalIgnoreCase)
                    || attrs.Contains("arrowhead=open", StringComparison.OrdinalIgnoreCase)
                    || attrs.Contains("arrowhead = open", StringComparison.OrdinalIgnoreCase)
                ? "implementation" : "interface";
            AddEdge(units, source, target, kind);
        }

        if (programName != null && units.TryGetValue(programName, out var programUnit))
            programUnit.UnitType = "Program";

        return units;
    }

    private static void AddEdge(Dictionary<string, ProjectUnit> units, string source, string target, string kind)
    {
        var sourceUnit = GetOrAdd(units, source);
        GetOrAdd(units, target);

        if (kind == "implementation")
            sourceUnit.ImplementationUses.Add(target);
        else
            sourceUnit.InterfaceUses.Add(target);
    }

    private static ProjectUnit GetOrAdd(Dictionary<string, ProjectUnit> units, string name)
    {
        if (!units.TryGetValue(name, out var unit))
        {
            unit = new ProjectUnit { Name = name, FileFound = true };
            units[name] = unit;
        }
        return unit;
    }

    // DOT comments: "//" to end of line and "/* ... */" blocks. Unlike Pascal,
    // "{" / "}" are graph-body delimiters here, not comments — must stay intact.
    private static string StripComments(string text)
    {
        var sb = new System.Text.StringBuilder(text.Length);
        int i = 0;
        while (i < text.Length)
        {
            if (i + 1 < text.Length && text[i] == '/' && text[i + 1] == '/')
            {
                while (i < text.Length && text[i] != '\n') i++;
                continue;
            }
            if (i + 1 < text.Length && text[i] == '/' && text[i + 1] == '*')
            {
                i += 2;
                while (i + 1 < text.Length && !(text[i] == '*' && text[i + 1] == '/')) i++;
                i += 2;
                continue;
            }
            sb.Append(text[i]);
            i++;
        }
        return sb.ToString();
    }
}
