using System.IO;
using System.Windows;

namespace DelphiVisualizer;

public enum WelcomeChoice { None, OpenProject, OpenDemo }

// Shown on first start (no project selected yet): open a project of your own
// or the bundled demo project.
public partial class WelcomeDialog : Window
{
    public static string DemoProjectPath { get; } = Path.Combine(
        AppDomain.CurrentDomain.BaseDirectory, "SampleProject", "AcmeERP", "AcmeERP.dpr");

    public WelcomeChoice Choice { get; private set; } = WelcomeChoice.None;

    public WelcomeDialog()
    {
        InitializeComponent();
        NativeMethods.EnableDarkTitleBar(this);
        Icon = AppIconHelper.Get();
        BtnDemo.IsEnabled = File.Exists(DemoProjectPath);
    }

    private void BtnOpen_Click(object sender, RoutedEventArgs e)
    {
        Choice = WelcomeChoice.OpenProject;
        DialogResult = true;
    }

    private void BtnDemo_Click(object sender, RoutedEventArgs e)
    {
        Choice = WelcomeChoice.OpenDemo;
        DialogResult = true;
    }

    private void BtnLater_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = false;
    }
}
