using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Interop;

namespace DelphiVisualizer;

internal static class NativeMethods
{
    [DllImport("dwmapi.dll")]
    private static extern int DwmSetWindowAttribute(
        IntPtr hwnd, int attr, ref int attrValue, int attrSize);

    internal static void EnableDarkTitleBar(Window window)
    {
        window.SourceInitialized += (_, _) =>
        {
            var hwnd = new WindowInteropHelper(window).Handle;
            int on = 1;
            // DWMWA_USE_IMMERSIVE_DARK_MODE: 20 (Win10 20H1+, Win11), fallback 19
            if (DwmSetWindowAttribute(hwnd, 20, ref on, Marshal.SizeOf(on)) != 0)
                DwmSetWindowAttribute(hwnd, 19, ref on, Marshal.SizeOf(on));
        };
    }
}
