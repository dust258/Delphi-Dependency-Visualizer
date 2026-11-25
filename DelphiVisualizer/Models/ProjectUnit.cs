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

    // True if the .dpr names the file explicitly ("Unit1 in 'Unit1.pas'"); false for
    // plain names (RTL/library units) whose .pas we only guess.
    public bool ExplicitPath { get; set; }
}
