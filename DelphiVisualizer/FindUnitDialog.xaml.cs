using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace DelphiVisualizer;

// Small RFindUnit-style picker: type to filter the project's units, Enter or
// double-click to choose. Returns the chosen unit name in SelectedUnit.
public partial class FindUnitDialog : Window
{
    public sealed class Row
    {
        public string Name { get; init; } = "";
        public string Path { get; init; } = "";
        public string UnitType { get; init; } = "Unit";

        public SolidColorBrush Brush => new(Hex(UnitType switch
        {
            "Form"       => "#4FC3F7",
            "DataModule" => "#A5D6A7",
            "Frame"      => "#FFB74D",
            "Program"    => "#CE93D8",
            _            => "#B0BEC5"
        }));

        private static Color Hex(string h) => (Color)ColorConverter.ConvertFromString(h);
    }

    private readonly List<Row> _all;
    public string? SelectedUnit { get; private set; }

    public FindUnitDialog(IEnumerable<(string Name, string Path, string UnitType)> units, string? current)
    {
        InitializeComponent();
        NativeMethods.EnableDarkTitleBar(this);
        Icon = AppIconHelper.Get();

        _all = units
            .Select(u => new Row { Name = u.Name, Path = u.Path, UnitType = u.UnitType })
            .OrderBy(r => r.Name, StringComparer.OrdinalIgnoreCase)
            .ToList();

        ApplyFilter("");

        if (!string.IsNullOrEmpty(current))
        {
            var match = LbResults.Items.Cast<Row>()
                .FirstOrDefault(r => r.Name.Equals(current, StringComparison.OrdinalIgnoreCase));
            if (match != null)
            {
                LbResults.SelectedItem = match;
                LbResults.ScrollIntoView(match);
            }
        }

        Loaded += (_, _) => TbFilter.Focus();
    }

    private void ApplyFilter(string query)
    {
        var q = query.Trim();

        IEnumerable<Row> res = _all;
        if (q.Length > 0)
            res = _all
                .Where(r => r.Name.Contains(q, StringComparison.OrdinalIgnoreCase)
                         || r.Path.Contains(q, StringComparison.OrdinalIgnoreCase))
                .OrderBy(r => r.Name.StartsWith(q, StringComparison.OrdinalIgnoreCase) ? 0 : 1)
                .ThenBy(r => r.Name, StringComparer.OrdinalIgnoreCase);

        var list = res.ToList();
        LbResults.ItemsSource = list;
        if (list.Count > 0)
            LbResults.SelectedIndex = 0;

        TbCount.Text = $"{list.Count} / {_all.Count}";
    }

    private void TbFilter_TextChanged(object sender, TextChangedEventArgs e)
        => ApplyFilter(TbFilter.Text);

    private void TbFilter_PreviewKeyDown(object sender, KeyEventArgs e)
    {
        if (e.Key == Key.Down && LbResults.Items.Count > 0)
        {
            LbResults.Focus();
            if (LbResults.SelectedIndex < 0) LbResults.SelectedIndex = 0;
            (LbResults.ItemContainerGenerator.ContainerFromIndex(LbResults.SelectedIndex)
                as ListBoxItem)?.Focus();
            e.Handled = true;
        }
        else if (e.Key == Key.Enter)
        {
            Accept();
            e.Handled = true;
        }
    }

    private void LbResults_PreviewKeyDown(object sender, KeyEventArgs e)
    {
        if (e.Key == Key.Enter)
        {
            Accept();
            e.Handled = true;
        }
        else if (e.Key == Key.Up && LbResults.SelectedIndex == 0)
        {
            TbFilter.Focus();
            TbFilter.CaretIndex = TbFilter.Text.Length;
            e.Handled = true;
        }
    }

    private void LbResults_MouseDoubleClick(object sender, MouseButtonEventArgs e)
    {
        if (LbResults.SelectedItem is Row) Accept();
    }

    private void BtnSelect_Click(object sender, RoutedEventArgs e) => Accept();

    private void BtnCancel_Click(object sender, RoutedEventArgs e) => DialogResult = false;

    private void Accept()
    {
        var row = LbResults.SelectedItem as Row
                  ?? LbResults.Items.OfType<Row>().FirstOrDefault();
        if (row == null) return;
        SelectedUnit = row.Name;
        DialogResult = true;
    }
}
