using DelphiVisualizer.Models;
using System.IO;
using System.Text.RegularExpressions;

namespace DelphiVisualizer.Graph;

public static class NodeClassifier
{
    private static readonly Regex FormRegex =
        new(@"class\s*\(\s*T(?:Custom)?Form\b", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex DataModuleRegex =
        new(@"class\s*\(\s*T(?:Custom)?DataModule\b", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex FrameRegex =
        new(@"class\s*\(\s*T(?:Custom)?Frame\b", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public static void ClassifyAll(Dictionary<string, ProjectUnit> units)
    {
        foreach (var unit in units.Values)
            unit.UnitType = Classify(unit);
    }

    private static string Classify(ProjectUnit unit)
    {
        if (!unit.FileFound) return "Unit";

        // Check for matching .dfm file as a quick indicator of a visual component
        var dfmPath = Path.ChangeExtension(unit.AbsolutePath, ".dfm");
        var hasDfm = File.Exists(dfmPath);

        if (!hasDfm) return "Unit";

        // Read the .pas file content (already stripped of comments by PasParser, but
        // we only need a quick regex scan on the raw content here)
        try
        {
            var content = File.ReadAllText(unit.AbsolutePath);
            if (DataModuleRegex.IsMatch(content)) return "DataModule";
            if (FrameRegex.IsMatch(content)) return "Frame";
            if (FormRegex.IsMatch(content)) return "Form";

            // Has .dfm but couldn't match — still likely a Form descendant
            return "Form";
        }
        catch
        {
            return "Unit";
        }
    }
}
