using DelphiVisualizer.Services;
using System.Windows;

namespace DelphiVisualizer;

public partial class App : Application
{
    private void OnStartup(object sender, StartupEventArgs e)
    {
        AppDomain.CurrentDomain.UnhandledException += (s, ex) =>
        {
            ErrorLog.Write(ex.ExceptionObject as Exception ?? new Exception(ex.ExceptionObject?.ToString()),
                "Unhandled exception (terminating)");
            ShowUnexpectedError(ex.ExceptionObject as Exception);
        };
        DispatcherUnhandledException += (s, ex) =>
        {
            ErrorLog.Write(ex.Exception, "Unhandled UI exception");
            ex.Handled = true;
            ShowUnexpectedError(ex.Exception);
        };

        var savedLang = TryReadSavedLanguage();
        LocalizationManager.Boot(savedLang);

        var splash = new SplashWindow();
        splash.Show();

        var main = new MainWindow { SplashWindow = splash };
        MainWindow = main;
        main.Show();

        // Opt-in remote control for AI assistants: --mcp[=PORT] or env DELPHIVIZ_MCP=1|PORT
        var mcpPort = ParseMcpPort(e.Args);
        if (mcpPort > 0) main.StartMcp(mcpPort);
    }

    private static int ParseMcpPort(string[] args)
    {
        string? value = null;
        foreach (var a in args)
        {
            if (a.Equals("--mcp", StringComparison.OrdinalIgnoreCase)) value = "1";
            else if (a.StartsWith("--mcp=", StringComparison.OrdinalIgnoreCase)) value = a[6..];
        }
        value ??= Environment.GetEnvironmentVariable("DELPHIVIZ_MCP");
        if (string.IsNullOrWhiteSpace(value) || value == "0") return 0;
        return int.TryParse(value, out var p) && p > 1024 && p < 65536 ? p : McpServer.DefaultPort;
    }

    private static bool _showingError;

    // Previously exceptions were swallowed (handled, nothing shown) or written to a
    // file on the Desktop. Tell the user, and point to the log for bug reports.
    private static void ShowUnexpectedError(Exception? ex)
    {
        if (_showingError) return; // avoid a storm of dialogs from a repeating error
        _showingError = true;
        try
        {
            var text = L.T("errors.unhandled", ex?.Message ?? "?", ErrorLog.Path);
            if (text.StartsWith("errors."))   // language not loaded yet
                text = $"An unexpected error occurred:\n\n{ex?.Message}\n\nDetails: {ErrorLog.Path}";
            MessageBox.Show(text, "Delphi Dependency Visualizer",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
        catch { }
        finally { _showingError = false; }
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
