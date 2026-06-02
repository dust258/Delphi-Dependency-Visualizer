using System.IO;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace DelphiVisualizer;

/// <summary>
/// Erzeugt das App-Icon zur Laufzeit (Hexagon + Graph-Knoten, Dark-Theme).
/// Schreibt beim ersten Aufruf auch app.ico in das Ausgabeverzeichnis,
/// damit es bei Bedarf als ApplicationIcon in der .csproj referenziert werden kann.
/// </summary>
internal static class AppIconHelper
{
    private static BitmapSource? _icon;

    internal static BitmapSource Get()
    {
        if (_icon != null) return _icon;

        _icon = Render(32, 32);

        // ICO für das .exe-Dateiicon schreiben (einmalig)
        var icoPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "app.ico");
        if (!File.Exists(icoPath))
        {
            try { File.WriteAllBytes(icoPath, ToIcoBytes(_icon)); } catch { }
        }

        return _icon;
    }

    private static BitmapSource Render(int w, int h)
    {
        double cx = w / 2.0, cy = h / 2.0;

        var visual = new DrawingVisual();
        using (var dc = visual.RenderOpen())
        {
            // Hintergrund
            dc.DrawRectangle(
                new SolidColorBrush(Color.FromRgb(0x0A, 0x0E, 0x1A)), null,
                new Rect(0, 0, w, h));

            // Hexagon-Umriss
            dc.DrawGeometry(
                null,
                new Pen(new SolidColorBrush(Color.FromRgb(0x64, 0xB5, 0xF6)) { Opacity = 0.95 }, 1.6),
                Hexagon(cx, cy, cx - 2.5));

            // Kanten (Graph)
            var ep = new Pen(new SolidColorBrush(Color.FromArgb(180, 0x64, 0xB5, 0xF6)), 1.2);
            var root = new Point(cx, cy - cx * 0.42);
            var left = new Point(cx - cx * 0.44, cy + cx * 0.35);
            var right = new Point(cx + cx * 0.44, cy + cx * 0.35);
            dc.DrawLine(ep, root, left);
            dc.DrawLine(ep, root, right);
            dc.DrawLine(ep, left, right);

            // Knoten
            double rr = cx * 0.26, nr = cx * 0.19;
            dc.DrawEllipse(new SolidColorBrush(Color.FromRgb(0xFF, 0x6B, 0x6B)), null, root,  rr, rr);
            dc.DrawEllipse(new SolidColorBrush(Color.FromRgb(0x4F, 0xC3, 0xF7)), null, left,  nr, nr);
            dc.DrawEllipse(new SolidColorBrush(Color.FromRgb(0xA5, 0xD6, 0xA7)), null, right, nr, nr);
        }

        var rtb = new RenderTargetBitmap(w, h, 96, 96, PixelFormats.Pbgra32);
        rtb.Render(visual);
        rtb.Freeze();
        return rtb;
    }

    private static StreamGeometry Hexagon(double cx, double cy, double r)
    {
        var geo = new StreamGeometry();
        using (var ctx = geo.Open())
        {
            bool first = true;
            for (int i = 0; i < 6; i++)
            {
                double a = Math.PI / 2 + i * Math.PI / 3;
                var pt = new Point(cx + r * Math.Cos(a), cy + r * Math.Sin(a));
                if (first) { ctx.BeginFigure(pt, false, true); first = false; }
                else ctx.LineTo(pt, true, false);
            }
        }
        geo.Freeze();
        return geo;
    }

    // PNG-in-ICO (Windows Vista+): 1 Bild, 32×32, 32-bit
    private static byte[] ToIcoBytes(BitmapSource src)
    {
        var enc = new PngBitmapEncoder();
        enc.Frames.Add(BitmapFrame.Create(src));
        using var png = new MemoryStream();
        enc.Save(png);
        var pngBytes = png.ToArray();

        using var ico = new MemoryStream();
        using var w = new BinaryWriter(ico);
        w.Write((short)0); w.Write((short)1); w.Write((short)1); // ICONDIR
        w.Write((byte)32); w.Write((byte)32);                    // width, height
        w.Write((byte)0);  w.Write((byte)0);                    // color count, reserved
        w.Write((short)1); w.Write((short)32);                  // planes, bit count
        w.Write(pngBytes.Length); w.Write(22);                  // size, offset
        w.Write(pngBytes);
        return ico.ToArray();
    }
}
