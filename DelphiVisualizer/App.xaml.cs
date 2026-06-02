using DelphiVisualizer.Services;
using System.Windows;

namespace DelphiVisualizer;

public partial class App : Application
{
    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);
        // Sprache aus settings.json lesen — MainWindow lädt Settings danach erneut,
        // aber für Boot reicht ein schneller Vorab-Lesevorgang.
        var savedLang = TryReadSavedLanguage();
        LocalizationManager.Boot(savedLang);
    }

    private static string? TryReadSavedLanguage()
    {
        try
        {
            var path = System.IO.Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                "DelphiVisualizer", "settings.json");
            if (!System.IO.File.Exists(path)) return null;
            using var doc = System.Text.Json.JsonDocument.Parse(System.IO.File.ReadAllText(path));
            return doc.RootElement.TryGetProperty("Language", out var v) ? v.GetString() : null;
        }
        catch { return null; }
    }
}
