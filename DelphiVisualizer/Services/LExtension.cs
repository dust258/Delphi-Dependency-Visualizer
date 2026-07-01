using System.Windows;
using System.Windows.Markup;

namespace DelphiVisualizer.Services;

/// <summary>
/// XAML Markup-Extension {s:L key} — übersetzt einen Key zur Laufzeit
/// und aktualisiert das Ziel-DependencyProperty bei Sprachänderung.
/// </summary>
[MarkupExtensionReturnType(typeof(string))]
public class LExtension : MarkupExtension
{
    public LExtension() { }
    public LExtension(string key) { Key = key; }

    public string Key { get; set; } = "";

    public override object ProvideValue(IServiceProvider serviceProvider)
    {
        // Ziel-Property für Runtime-Updates merken
        if (serviceProvider.GetService(typeof(IProvideValueTarget)) is IProvideValueTarget pvt
            && pvt.TargetObject is DependencyObject targetObj
            && pvt.TargetProperty is DependencyProperty targetProp)
        {
            var capturedObj  = targetObj;
            var capturedProp = targetProp;
            var capturedKey  = Key;

            LocalizationManager.LanguageChanged += () =>
                capturedObj.Dispatcher.BeginInvoke(() =>
                    capturedObj.SetCurrentValue(capturedProp, LocalizationManager.Get(capturedKey)));
        }

        return LocalizationManager.Get(Key);
    }
}
