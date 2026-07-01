using System.Windows;
using System.Windows.Media.Animation;

namespace DelphiVisualizer;

public partial class SplashWindow : Window
{
    public SplashWindow()
    {
        InitializeComponent();
        var v = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version!;
        TbVersion.Text = $"v{v.Major}.{v.Minor}.{v.Build}  ·  Michael Bröker";
        Loaded += (_, _) => BeginAnimation(OpacityProperty,
            new DoubleAnimation(0, 1, TimeSpan.FromMilliseconds(250)));
    }

    public void CloseSplash()
    {
        Dispatcher.Invoke(() =>
        {
            var fade = new DoubleAnimation(1, 0, TimeSpan.FromMilliseconds(300));
            fade.Completed += (_, _) => Close();
            BeginAnimation(OpacityProperty, fade);
        });
    }
}
