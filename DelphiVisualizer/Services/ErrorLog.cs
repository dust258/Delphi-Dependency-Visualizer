using System.IO;

namespace DelphiVisualizer.Services;

// Persistent error log (%APPDATA%\DelphiVisualizer\error.log) so startup and crash
// problems can be diagnosed from a bug report instead of failing silently.
public static class ErrorLog
{
    private const long MaxBytes = 512 * 1024;
    private static readonly object Gate = new();

    public static string Path { get; } = System.IO.Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
        "DelphiVisualizer", "error.log");

    public static void Write(string message)
    {
        try
        {
            lock (Gate)
            {
                Directory.CreateDirectory(System.IO.Path.GetDirectoryName(Path)!);
                // Keep the file small: start over once it grows too large.
                if (File.Exists(Path) && new FileInfo(Path).Length > MaxBytes)
                    File.Delete(Path);

                var v = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version;
                File.AppendAllText(Path,
                    $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] v{v?.Major}.{v?.Minor}.{v?.Build} " +
                    $"{Environment.OSVersion.VersionString} .NET {Environment.Version}\n{message}\n\n");
            }
        }
        catch { /* logging must never throw */ }
    }

    public static void Write(Exception ex, string context = "") =>
        Write((string.IsNullOrEmpty(context) ? "" : context + "\n") + ex);
}
