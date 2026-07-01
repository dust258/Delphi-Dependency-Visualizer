using DelphiVisualizer.Services;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using static DelphiVisualizer.Services.L;

namespace DelphiVisualizer;

public partial class OptionsDialog : Window
{
    public int    MaxNodes { get; private set; }
    public string Language { get; private set; } = LocalizationManager.CurrentLanguage;

    public OptionsDialog(int currentMaxNodes)
    {
        InitializeComponent();
        NativeMethods.EnableDarkTitleBar(this);
        Icon = AppIconHelper.Get();
        MaxNodes = currentMaxNodes;
        TbMaxNodes.Text = currentMaxNodes.ToString();

        // Language ComboBox auf aktuelle Sprache setzen
        foreach (ComboBoxItem item in CbLanguage.Items)
            if ((string)item.Tag == LocalizationManager.CurrentLanguage)
            { CbLanguage.SelectedItem = item; break; }

        Loaded += (_, _) => { TbMaxNodes.SelectAll(); TbMaxNodes.Focus(); };
    }

    private void TbMaxNodes_PreviewTextInput(object sender, TextCompositionEventArgs e)
    {
        e.Handled = !e.Text.All(char.IsDigit);
    }

    private void TbMaxNodes_PreviewKeyDown(object sender, KeyEventArgs e)
    {
        if (e.Key == Key.Space) e.Handled = true;
    }

    private void BtnOk_Click(object sender, RoutedEventArgs e)
    {
        if (int.TryParse(TbMaxNodes.Text, out var n) && n >= 100)
        {
            MaxNodes = n;
            Language = (CbLanguage.SelectedItem as ComboBoxItem)?.Tag as string
                       ?? LocalizationManager.CurrentLanguage;
            DialogResult = true;
        }
        else
        {
            MessageBox.Show(T("options.validationMaxNodes"),
                T("errors.title"), MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void BtnCancel_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = false;
    }
}
