namespace DelphiVisualizer.Models;

public class DependencyGraph
{
    public Dictionary<string, ProjectUnit> Units { get; set; } = new();
    public List<DependencyEdge> Edges { get; set; } = new();
    public List<List<string>> Cycles { get; set; } = new();
    public string RootUnit { get; set; } = "";
}
