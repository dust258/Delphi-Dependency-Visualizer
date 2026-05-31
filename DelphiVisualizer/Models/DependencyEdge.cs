namespace DelphiVisualizer.Models;

public class DependencyEdge
{
    public string Source { get; set; } = "";
    public string Target { get; set; } = "";
    public string Kind { get; set; } = "interface";
    public bool IsCyclic { get; set; }
}
