using DelphiVisualizer.Services;
using System.Windows;

namespace DelphiVisualizer;

public partial class App : Application
{
    private void OnStartup(object sender, StartupEventArgs e)
    {
        AppDomain.CurrentDomain.UnhandledException += (s, ex) =>
            LogCrash(ex.ExceptionObject as Exception);
        DispatcherUnhandledException += (s, ex) =>
        { LogCrash(ex.Exception); ex.Handled = true; };

        var savedLang = TryReadSavedLanguage();
        LocalizationManager.Boot(savedLang);

        var splash = new SplashWindow();
        splash.Show();

        var main = new MainWindow { SplashWindow = splash };
        MainWindow = main;
        main.Show();
    }

    private static void LogCrash(Exception? ex)
    {
        try
        {
            var path = System.IO.Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
                "DelphiVisualizer-crash.txt");
            System.IO.File.WriteAllText(path,
                $"{DateTime.Now}\n{ex?.GetType().FullName}\n{ex?.Message}\n{ex?.StackTrace}\n\nInner: {ex?.InnerException}");
        }
        catch { }
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
