namespace DelphiVisualizer.Models;

public class ProjectUnit
{
    public string Name { get; set; } = "";
    public string FilePath { get; set; } = "";
    public string AbsolutePath { get; set; } = "";
    public string UnitType { get; set; } = "Unit";
    public List<string> InterfaceUses { get; set; } = new();
    public List<string> ImplementationUses { get; set; } = new();
    public bool FileFound { get; set; } = true;
}
