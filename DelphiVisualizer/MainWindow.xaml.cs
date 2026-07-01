using DelphiVisualizer.Graph;
using DelphiVisualizer.Models;
using DelphiVisualizer.Parser;
using DelphiVisualizer.Services;
using Microsoft.Web.WebView2.Core;
using System.Collections.ObjectModel;
using System.Text.Json;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using static DelphiVisualizer.Services.L;

namespace DelphiVisualizer;

public partial class MainWindow : Window
{
    private Dictionary<string, ProjectUnit> _projectUnits = new();
    private DependencyGraph? _currentGraph;
    private bool _webViewReady = false;
    private string? _pendingGraphJson;
    private string _filterType = "All";

    // Unit search picker state
    private List<string> _allUnitNames = new();
    private string _selectedUnit = "";
    private bool _suppressTextChange = false;

    // Persistence
    private string? _currentProjectPath;
    private bool _autoAnalyzeOnReady = false;
    private int _maxNodes = 20000;
    private static readonly string SettingsPath = System.IO.Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
        "DelphiVisualizer", "settings.json");

    private readonly ObservableCollection<UnitListItem> _allUnitItems = new();
    private readonly ObservableCollection<UnitListItem> _filteredItems = new();

    public MainWindow()
    {
        InitializeComponent();
        LbUnits.ItemsSource = _filteredItems;
        SetActiveLayoutButton(BtnForce);
        NativeMethods.EnableDarkTitleBar(this);
        Icon = AppIconHelper.Get();

        LocalizationManager.LanguageChanged += OnLanguageChanged;

        _ = InitWebViewAsync();
        TryRestoreLastSession();
    }

    // ── Settings persistence ─────────────────────────────────

    private record AppSettings(string ProjectPath, string Unit, int Depth, int MaxNodes = 20000, string Language = "de");

    // Für LocalizationManager.NotifyWebViewAsync
    public bool IsWebViewReady => _webViewReady;

    public SplashWindow? SplashWindow { get; set; }

    private void SaveSettings()
    {
        try
        {
            if (string.IsNullOrEmpty(_currentProjectPath)) return;
            var dir = System.IO.Path.GetDirectoryName(SettingsPath)!;
            System.IO.Directory.CreateDirectory(dir);
            var settings = new AppSettings(
                _currentProjectPath, _selectedUnit, (int)SlDepth.Value, _maxNodes,
                LocalizationManager.CurrentLanguage);
            System.IO.File.WriteAllText(SettingsPath,
                JsonSerializer.Serialize(settings));
        }
        catch { }
    }

    private void TryRestoreLastSession()
    {
        try
        {
            if (!System.IO.File.Exists(SettingsPath)) return;
            var settings = JsonSerializer.Deserialize<AppSettings>(
                System.IO.File.ReadAllText(SettingsPath));
            if (settings == null || !System.IO.File.Exists(settings.ProjectPath))
                return;

            SlDepth.Value = settings.Depth > 0 ? settings.Depth : 3;
            _maxNodes = settings.MaxNodes > 0 ? settings.MaxNodes : 20000;
            LocalizationManager.Boot(settings.Language);
            LoadProject(settings.ProjectPath, settings.Unit);
            // Auto-analyze once the WebView is ready
            _autoAnalyzeOnReady = !string.IsNullOrEmpty(settings.Unit);
        }
        catch { }
    }

    // ── WebView2 ─────────────────────────────────────────────

    private async Task InitWebViewAsync()
    {
        await WebView.EnsureCoreWebView2Async();

        var webFolder = System.IO.Path.Combine(
            AppDomain.CurrentDomain.BaseDirectory, "Web");
        WebView.CoreWebView2.SetVirtualHostNameToFolderMapping(
            "app.local", webFolder, CoreWebView2HostResourceAccessKind.Allow);

        WebView.CoreWebView2.WebMessageReceived += CoreWebView2_WebMessageReceived;
        WebView.CoreWebView2.Settings.AreDevToolsEnabled = true;
        WebView.CoreWebView2.Settings.AreBrowserAcceleratorKeysEnabled = true;
        WebView.CoreWebView2.Settings.AreDefaultContextMenusEnabled = false;

        WebView.Source = new Uri("https://app.local/index.html");
    }

    private void WebView_NavigationCompleted(object sender,
        CoreWebView2NavigationCompletedEventArgs e)
    {
        if (!e.IsSuccess) return;

        Dispatcher.InvokeAsync(async () =>
        {
            await Task.Delay(300);
            _webViewReady = true;
            SplashWindow?.CloseSplash();
            SplashWindow = null;

            // Sprache ins WebView propagieren
            await LocalizationManager.SendToWebViewAsync(WebView);

            if (_pendingGraphJson != null)
            {
                var json = _pendingGraphJson;
                _pendingGraphJson = null;
                SendGraphToWebView(json);
            }
            // Auto-analyze the restored session once everything is ready
            if (_autoAnalyzeOnReady && !string.IsNullOrEmpty(_selectedUnit))
            {
                _autoAnalyzeOnReady = false;
                AnalyzeDependencies(_selectedUnit);
            }
        });
    }

    private void CoreWebView2_WebMessageReceived(object? sender,
        CoreWebView2WebMessageReceivedEventArgs e)
    {
        try
        {
            // WebMessageAsJson may be a quoted string if JS used postMessage(JSON.stringify(...))
            var raw = e.WebMessageAsJson;
            if (raw.StartsWith('"'))
                raw = JsonSerializer.Deserialize<string>(raw) ?? raw;

            var msg = JsonSerializer.Deserialize<Dictionary<string, JsonElement>>(raw);
            if (msg == null) return;

            var type = msg.GetValueOrDefault("type").GetString();

            if (type == "log")
            {
                var logMsg = msg.GetValueOrDefault("msg").GetString() ?? "";
                var line = $"[{DateTime.Now:HH:mm:ss.fff}] {logMsg}";
                System.IO.File.AppendAllText(@"C:\temp\graph-log.txt", line + "\n");
                return;
            }

            if (type == "screenshot")
            {
                var shotName = msg.TryGetValue("name", out var nm) ? nm.GetString() : null;
                var file = string.IsNullOrEmpty(shotName)
                    ? @"C:\temp\webview.png"
                    : $@"C:\temp\{shotName}.png";
                Dispatcher.Invoke(async () =>
                {
                    try
                    {
                        using var fs = new System.IO.FileStream(file, System.IO.FileMode.Create);
                        await WebView.CoreWebView2.CapturePreviewAsync(
                            CoreWebView2CapturePreviewImageFormat.Png, fs);
                    }
                    catch { }
                });
                return;
            }

            Dispatcher.Invoke(() =>
            {
                if (type == "nodeClick")
                {
                    var nodeId = msg.GetValueOrDefault("id").GetString();
                    if (!string.IsNullOrEmpty(nodeId))
                        SelectUnitInSidebar(nodeId);
                }
                else if (type == "toggleFullscreen")
                {
                    ToggleFullscreen();
                }
                else if (type == "exitFullscreen")
                {
                    if (_isFullscreen) ToggleFullscreen();
                }
            });
        }
        catch { }
    }

    // ── Project loading ──────────────────────────────────────

    private void BtnOpen_Click(object sender, RoutedEventArgs e)
    {
        var dlg = new Microsoft.Win32.OpenFileDialog
        {
            Title  = T("filedialog.openTitle"),
            Filter = T("filedialog.openFilter"),
            DefaultExt = ".dpr"
        };
        if (dlg.ShowDialog() != true) return;
        LoadProject(dlg.FileName);
    }

    private void LoadProject(string dprPath, string? preferUnit = null)
    {
        try
        {
            SetStatus(T("status.loading"));
            _currentProjectPath = dprPath;
            _projectUnits = DprParser.Parse(dprPath);
            NodeClassifier.ClassifyAll(_projectUnits);

            _allUnitNames = _projectUnits.Keys
                .OrderBy(k => k, StringComparer.OrdinalIgnoreCase)
                .ToList();

            SetUnitPickerItems(_allUnitNames);

            // Pre-select preferred unit if valid, else first
            if (!string.IsNullOrEmpty(preferUnit) && _projectUnits.ContainsKey(preferUnit))
                SelectUnit(preferUnit);
            else if (_allUnitNames.Count > 0)
                SelectUnit(_allUnitNames[0]);

            TbUnitSearch.IsEnabled = true;
            SlDepth.IsEnabled = true;
            BtnAnalyze.IsEnabled = _allUnitNames.Count > 0;
            SetStatus(T("status.projectLoaded", _projectUnits.Count, System.IO.Path.GetFileName(dprPath)));
        }
        catch (Exception ex)
        {
            MessageBox.Show(T("errors.loadFailed", ex.Message),
                T("errors.title"), MessageBoxButton.OK, MessageBoxImage.Error);
            SetStatus(T("status.loadError"));
        }
    }

    // ── Unit Search Picker ───────────────────────────────────

    private void SetUnitPickerItems(IEnumerable<string> items)
    {
        LbUnitPicker.ItemsSource = items.ToList();
    }

    private void SelectUnit(string name)
    {
        _selectedUnit = name;
        _suppressTextChange = true;
        TbUnitSearch.Text = name;
        _suppressTextChange = false;
    }

    private void TbUnitSearch_GotFocus(object sender, RoutedEventArgs e)
    {
        UnitPickerBorder.BorderBrush = new SolidColorBrush(
            (Color)ColorConverter.ConvertFromString("#64B5F6"));
        TbUnitSearch.SelectAll();
        ShowFilteredDropdown(TbUnitSearch.Text);
    }

    private void TbUnitSearch_LostFocus(object sender, RoutedEventArgs e)
    {
        UnitPickerBorder.BorderBrush = new SolidColorBrush(
            (Color)ColorConverter.ConvertFromString("#2A3A60"));

        // Restore last valid selection if text doesn't match a known unit
        Dispatcher.InvokeAsync(() =>
        {
            if (!UnitPopup.IsOpen)
                RestoreSelection();
        });
    }

    private void TbUnitSearch_TextChanged(object sender, TextChangedEventArgs e)
    {
        if (_suppressTextChange) return;
        ShowFilteredDropdown(TbUnitSearch.Text);
    }

    private void ShowFilteredDropdown(string query)
    {
        if (_allUnitNames.Count == 0) return;

        var q = query.Trim();
        var filtered = string.IsNullOrEmpty(q)
            ? _allUnitNames
            : _allUnitNames
                .Where(n => n.Contains(q, StringComparison.OrdinalIgnoreCase))
                .OrderBy(n => {
                    // Exact start matches come first
                    if (n.StartsWith(q, StringComparison.OrdinalIgnoreCase)) return 0;
                    return 1;
                })
                .ThenBy(n => n, StringComparer.OrdinalIgnoreCase)
                .ToList();

        SetUnitPickerItems(filtered);
        UnitPopup.IsOpen = filtered.Count > 0;
    }

    private void TbUnitSearch_PreviewKeyDown(object sender, KeyEventArgs e)
    {
        switch (e.Key)
        {
            case Key.Down:
                if (UnitPopup.IsOpen && LbUnitPicker.Items.Count > 0)
                {
                    LbUnitPicker.SelectedIndex = 0;
                    LbUnitPicker.Focus();
                }
                e.Handled = true;
                break;

            case Key.Enter:
                var first = LbUnitPicker.Items.OfType<string>().FirstOrDefault();
                if (first != null) ConfirmSelection(first);
                e.Handled = true;
                break;

            case Key.Escape:
                UnitPopup.IsOpen = false;
                RestoreSelection();
                e.Handled = true;
                break;
        }
    }

    private void LbUnitPicker_PreviewKeyDown(object sender, KeyEventArgs e)
    {
        switch (e.Key)
        {
            case Key.Enter:
                if (LbUnitPicker.SelectedItem is string sel)
                    ConfirmSelection(sel);
                e.Handled = true;
                break;

            case Key.Escape:
                UnitPopup.IsOpen = false;
                RestoreSelection();
                TbUnitSearch.Focus();
                e.Handled = true;
                break;

            case Key.Up:
                if (LbUnitPicker.SelectedIndex == 0)
                {
                    TbUnitSearch.Focus();
                    e.Handled = true;
                }
                break;
        }
    }

    private void LbUnitPicker_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (LbUnitPicker.SelectedItem is string name)
            ConfirmSelection(name);
    }

    private void UnitPopup_Opened(object sender, EventArgs e)
    {
        // Scroll selected item into view
        if (!string.IsNullOrEmpty(_selectedUnit))
        {
            var idx = (LbUnitPicker.ItemsSource as List<string>)
                ?.IndexOf(_selectedUnit) ?? -1;
            if (idx >= 0)
            {
                LbUnitPicker.SelectedIndex = idx;
                LbUnitPicker.ScrollIntoView(LbUnitPicker.SelectedItem);
            }
        }
    }

    private void ConfirmSelection(string name)
    {
        SelectUnit(name);
        UnitPopup.IsOpen = false;
        BtnAnalyze.IsEnabled = true;
        TbUnitSearch.Focus();
    }

    private void RestoreSelection()
    {
        if (!string.IsNullOrEmpty(_selectedUnit))
            SelectUnit(_selectedUnit);
        else if (_allUnitNames.Count > 0)
            SelectUnit(_allUnitNames[0]);
    }

    // ── Analysis ─────────────────────────────────────────────

    private void BtnAnalyze_Click(object sender, RoutedEventArgs e)
    {
        UnitPopup.IsOpen = false;
        var unit = TbUnitSearch.Text.Trim();
        if (string.IsNullOrEmpty(unit)) return;

        // Accept only known units
        if (!_projectUnits.ContainsKey(unit))
        {
            var match = _allUnitNames.FirstOrDefault(
                n => n.Equals(unit, StringComparison.OrdinalIgnoreCase));
            if (match == null) return;
            unit = match;
        }

        SelectUnit(unit);
        AnalyzeDependencies(unit);
    }

    private void SlDepth_ValueChanged(object sender,
        System.Windows.RoutedPropertyChangedEventArgs<double> e)
    {
        if (TbDepth == null) return;
        var v = (int)SlDepth.Value;
        TbDepth.Text = v >= 10 ? "∞" : v.ToString();
    }

    private void AnalyzeDependencies(string rootUnit)
    {
        SetStatus(T("status.analyzing"));
        _selectedUnit = rootUnit;
        SaveSettings();
        _ = WebView.ExecuteScriptAsync($"showLoading('{EscapeJson(T("loading.analyzing"))}')");


        var maxDepth = (int)SlDepth.Value >= 10 ? int.MaxValue : (int)SlDepth.Value;

        Task.Run(() =>
        {
            var graph = DependencyResolver.Resolve(rootUnit, _projectUnits, maxDepth);
            var json = GraphBuilder.BuildJson(graph);

            Dispatcher.Invoke(() =>
            {
                _currentGraph = graph;
                BuildSidebarList(graph);

                if (_webViewReady)
                    SendGraphToWebView(json);
                else
                    _pendingGraphJson = json;

                var cycleText = graph.Cycles.Count > 0
                    ? T("status.cycles", graph.Cycles.Count) : "";
                SetStatus(T("status.graphLoaded", graph.Units.Count, graph.Edges.Count) + cycleText);
            });
        });
    }

    private async void SendGraphToWebView(string json)
    {
        await WebView.ExecuteScriptAsync($"setMaxNodes({_maxNodes})");
        await WebView.ExecuteScriptAsync($"loadGraph({json})");
    }

    // ── Sidebar ──────────────────────────────────────────────

    private void BuildSidebarList(DependencyGraph graph)
    {
        _allUnitItems.Clear();

        var cycleNodes = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        foreach (var cycle in graph.Cycles)
            foreach (var n in cycle)
                cycleNodes.Add(n);

        var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        void AddIfNew(string name)
        {
            if (!seen.Add(name)) return;
            graph.Units.TryGetValue(name, out var unit);
            var unitType = unit?.UnitType ?? "Unit";
            var isInCycle = cycleNodes.Contains(name);
            _allUnitItems.Add(new UnitListItem
            {
                Name = name,
                UnitType = unitType,
                IsInCycle = isInCycle,
                Brush = MakeBrush(name, unitType, graph.RootUnit, isInCycle)
            });
        }

        AddIfNew(graph.RootUnit);
        foreach (var edge in graph.Edges)
        {
            AddIfNew(edge.Source);
            AddIfNew(edge.Target);
        }

        ApplyFilter();
    }

    private static SolidColorBrush MakeBrush(
        string name, string unitType, string rootUnit, bool isInCycle)
    {
        var hex = isInCycle ? "#FF5252"
            : name.Equals(rootUnit, StringComparison.OrdinalIgnoreCase) ? "#FF6B6B"
            : unitType switch
            {
                "Form"       => "#4FC3F7",
                "DataModule" => "#A5D6A7",
                "Frame"      => "#FFB74D",
                _            => "#B0BEC5"
            };
        return new SolidColorBrush((Color)ColorConverter.ConvertFromString(hex));
    }

    private void ApplyFilter()
    {
        var search = TbSearch.Text?.Trim() ?? "";
        _filteredItems.Clear();

        var items = _allUnitItems.AsEnumerable();

        if (!string.IsNullOrEmpty(search))
            items = items.Where(i =>
                i.Name.Contains(search, StringComparison.OrdinalIgnoreCase));

        if (_filterType == "Cycles")
            items = items.Where(i => i.IsInCycle);
        else if (_filterType != "All")
            items = items.Where(i => i.UnitType == _filterType);

        foreach (var item in items.OrderBy(i => i.Name))
            _filteredItems.Add(item);

        TbUnitCount.Text = T("sidebar.unitCount", _filteredItems.Count, _allUnitItems.Count);
    }

    private void SelectUnitInSidebar(string nodeId)
    {
        var item = _filteredItems.FirstOrDefault(i =>
            i.Name.Equals(nodeId, StringComparison.OrdinalIgnoreCase));
        if (item != null)
        {
            LbUnits.SelectedItem = item;
            LbUnits.ScrollIntoView(item);
        }
    }

    private void LbUnits_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (LbUnits.SelectedItem is UnitListItem item)
            _ = WebView.ExecuteScriptAsync($"highlightNode('{item.Name}')");
    }

    private void TbSearch_TextChanged(object sender, TextChangedEventArgs e)
        => ApplyFilter();

    private void BtnFilter_Click(object sender, RoutedEventArgs e)
    {
        if (sender is Button btn && btn.Tag is string tag)
        {
            _filterType = tag;
            ApplyFilter();
        }
    }

    // ── Graph-Filter ─────────────────────────────────────────

    private bool _suppressFilterChanged = false;

    private void GraphFilter_Changed(object sender, RoutedEventArgs e)
    {
        if (_suppressFilterChanged || !_webViewReady) return;
        SendVisFilter();
    }

    private void BtnResetFilter_Click(object sender, RoutedEventArgs e)
    {
        _suppressFilterChanged = true;
        CbFormsOnly.IsChecked = false;
        CbDirFilter.IsChecked = false;
        CbUsesFiltered.IsChecked = false;
        _suppressFilterChanged = false;
        SendVisFilter();
    }

    private void SendVisFilter()
    {
        if (!_webViewReady) return;
        var formsOnly    = CbFormsOnly.IsChecked    == true ? "true" : "false";
        var sameDir      = CbDirFilter.IsChecked     == true ? "true" : "false";
        var usesFiltered = CbUsesFiltered.IsChecked  == true ? "true" : "false";
        _ = WebView.ExecuteScriptAsync(
            $"setVisFilter({{\"formsOnly\":{formsOnly},\"sameDir\":{sameDir},\"usesFiltered\":{usesFiltered}}})");
    }

    private static string EscapeJson(string s) =>
        s.Replace("\\", "\\\\").Replace("\"", "\\\"");

    // ── Layout / Camera ──────────────────────────────────────

    private void SetActiveLayoutButton(Button active)
    {
        var activeStyle   = (Style)FindResource("LayoutButtonActive");
        var defaultStyle  = (Style)FindResource("LayoutButton");
        foreach (var btn in new[] { BtnLayered, BtnForce, BtnTree, BtnRadial })
            btn.Style = btn == active ? activeStyle : defaultStyle;
    }

    private void BtnLayered_Click(object sender, RoutedEventArgs e)
    {
        SetActiveLayoutButton(BtnLayered);
        _ = WebView.ExecuteScriptAsync("setLayoutMode('layered')");
    }

    private void BtnForce_Click(object sender, RoutedEventArgs e)
    {
        SetActiveLayoutButton(BtnForce);
        _ = WebView.ExecuteScriptAsync("setLayoutMode('force')");
    }

    private void BtnTree_Click(object sender, RoutedEventArgs e)
    {
        SetActiveLayoutButton(BtnTree);
        _ = WebView.ExecuteScriptAsync("setLayoutMode('tree')");
    }

    private void BtnRadial_Click(object sender, RoutedEventArgs e)
    {
        SetActiveLayoutButton(BtnRadial);
        _ = WebView.ExecuteScriptAsync("setLayoutMode('radial')");
    }

    private void BtnResetCamera_Click(object sender, RoutedEventArgs e)
        => _ = WebView.ExecuteScriptAsync("resetCamera()");

    // ── Sprache ──────────────────────────────────────────────

    private void OnLanguageChanged()
    {
        // WPF-Properties die nicht per {s:L} gebunden sind hier manuell aktualisieren
        TbStatus.Text = T("status.noProjectLoaded");
        Title = T("app.title");
    }

    // ── Optionen ─────────────────────────────────────────────

    private void BtnOptions_Click(object sender, RoutedEventArgs e)
    {
        var dlg = new OptionsDialog(_maxNodes) { Owner = this };
        if (dlg.ShowDialog() != true) return;
        _maxNodes = dlg.MaxNodes;
        if (dlg.Language != LocalizationManager.CurrentLanguage)
            LocalizationManager.SetLanguage(dlg.Language);
        SaveSettings();
        _ = WebView.ExecuteScriptAsync($"setMaxNodes({_maxNodes})");
    }

    private void BtnHelp_Click(object sender, RoutedEventArgs e)
        => _ = WebView.ExecuteScriptAsync("showHelp()");

    // ── Vollbild (nur Visualisierung) ────────────────────────

    private bool _isFullscreen = false;
    private WindowState _prevWindowState = WindowState.Maximized;

    private void BtnFullscreen_Click(object sender, RoutedEventArgs e) => ToggleFullscreen();

    public void ToggleFullscreen()
    {
        _isFullscreen = !_isFullscreen;
        if (_isFullscreen)
        {
            ToolbarBorder.Visibility = Visibility.Collapsed;
            SidebarBorder.Visibility = Visibility.Collapsed;
            MainSplitter.Visibility  = Visibility.Collapsed;
            SidebarColumn.MinWidth = 0; // sonst klemmt Width=0 auf MinWidth (schwarzer Balken)
            SidebarColumn.Width  = new GridLength(0);
            SplitterColumn.Width = new GridLength(0);

            _prevWindowState = WindowState == WindowState.Minimized ? WindowState.Maximized : WindowState;
            WindowState = WindowState.Normal;
            WindowStyle = WindowStyle.None;
            ResizeMode  = ResizeMode.NoResize;
            WindowState = WindowState.Maximized;
            _ = WebView.ExecuteScriptAsync("setFullscreenMode(true)");
        }
        else
        {
            ToolbarBorder.Visibility = Visibility.Visible;
            SidebarBorder.Visibility = Visibility.Visible;
            MainSplitter.Visibility  = Visibility.Visible;
            SidebarColumn.MinWidth = 160;
            SidebarColumn.Width  = new GridLength(220);
            SplitterColumn.Width = new GridLength(4);

            WindowStyle = WindowStyle.SingleBorderWindow;
            ResizeMode  = ResizeMode.CanResize;
            WindowState = _prevWindowState;
            _ = WebView.ExecuteScriptAsync("setFullscreenMode(false)");
        }
    }

    private void SetStatus(string text) => TbStatus.Text = text;
}

public class UnitListItem
{
    public string Name { get; set; } = "";
    public string UnitType { get; set; } = "Unit";
    public bool IsInCycle { get; set; }
    public SolidColorBrush Brush { get; set; } = Brushes.Gray;
}
