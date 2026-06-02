using System.Globalization;
using System.IO;
using System.Text.Json;
using System.Windows;

namespace DelphiVisualizer.Services;

public static class LocalizationManager
{
    private static readonly string[] SupportedLanguages = ["de", "en", "fr", "ru"];
    private static Dictionary<string, string> _dict = new();

    public static string CurrentLanguage { get; private set; } = "de";
    public static event Action? LanguageChanged;

    public static void Boot(string? savedLanguage)
    {
        var lang = savedLanguage ?? DetectSystemLanguage();
        SetLanguage(lang, notify: false);
    }

    public static void SetLanguage(string lang, bool notify = true)
    {
        if (!SupportedLanguages.Contains(lang)) lang = "de";
        CurrentLanguage = lang;
        _dict = LoadJson(lang);
        if (notify) LanguageChanged?.Invoke();
        _ = NotifyWebViewAsync();
    }

    public static string Get(string key, params object[] args)
    {
        var s = _dict.GetValueOrDefault(key, key);
        return args.Length == 0 ? s : string.Format(s, args);
    }

    private static string DetectSystemLanguage()
    {
        var twoLetter = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName.ToLower();
        return SupportedLanguages.Contains(twoLetter) ? twoLetter : "en";
    }

    private static Dictionary<string, string> LoadJson(string lang)
    {
        try
        {
            var path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "I18n", $"{lang}.json");
            if (!File.Exists(path)) return new();
            var json = File.ReadAllText(path);
            return JsonSerializer.Deserialize<Dictionary<string, string>>(json) ?? new();
        }
        catch { return new(); }
    }

    public static async Task SendToWebViewAsync(Microsoft.Web.WebView2.Wpf.WebView2 webView)
    {
        try
        {
            var dictJson = JsonSerializer.Serialize(_dict);
            await webView.ExecuteScriptAsync(
                $"typeof setLanguage==='function' && setLanguage('{CurrentLanguage}',{dictJson})");
        }
        catch { }
    }

    private static async Task NotifyWebViewAsync()
    {
        try
        {
            if (Application.Current?.MainWindow is not MainWindow mw || !mw.IsWebViewReady) return;
            await SendToWebViewAsync(mw.WebView);
        }
        catch { }
    }
}

// Kurzschreibweise für Code-Behind: using static DelphiVisualizer.Services.L;
public static class L
{
    public static string T(string key, params object[] args)
        => LocalizationManager.Get(key, args);
}
