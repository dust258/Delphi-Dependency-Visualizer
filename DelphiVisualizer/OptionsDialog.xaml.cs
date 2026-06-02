using System.Windows;
using System.Windows.Input;

namespace DelphiVisualizer;

public partial class OptionsDialog : Window
{
    public int MaxNodes { get; private set; }

    public OptionsDialog(int currentMaxNodes)
    {
        InitializeComponent();
        NativeMethods.EnableDarkTitleBar(this);
        Icon = AppIconHelper.Get();
        MaxNodes = currentMaxNodes;
        TbMaxNodes.Text = currentMaxNodes.ToString();
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
            DialogResult = true;
        }
        else
        {
            MessageBox.Show("Bitte eine gültige Zahl (mindestens 100) eingeben.",
                "Ungültige Eingabe", MessageBoxButton.OK, MessageBoxImage.Warning);
        }
    }

    private void BtnCancel_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = false;
    }
}
