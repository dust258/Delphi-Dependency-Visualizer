# Delphi Dependency Visualizer — Claude-Dokumentation

## Projekt-Übersicht

C# / .NET 8 WPF-Desktop-App zur interaktiven 3D-Visualisierung von Delphi Unit-Abhängigkeiten.
Bestehende Tools zeigen nur flache 2D-Bäume; dieses Tool rendert navigierbare 3D-Graphen.

## Build & Start

```bat
# Build (dotnet ist NICHT im PATH — immer vollen Pfad)
"C:\Program Files\dotnet\dotnet.exe" build -c Release

# Start (immer Release, nie Debug)
bin\Release\net8.0-windows\DelphiVisualizer.exe
```

`build.bat` und `publish.bat` sind im Projektstamm vorhanden.

## Architektur

```
DelphiVisualizer/
├── Parser/
│   ├── DprParser.cs          — .dpr-Datei → Unit-Liste mit Dateipfaden
│   ├── PasParser.cs          — Comment-Stripping State Machine + uses-Extraktion
│   └── DependencyResolver.cs — Iterativer DFS, WHITE/GRAY/BLACK Zykelerkennung
├── Graph/
│   ├── GraphBuilder.cs       — Internes Modell → JSON für Three.js
│   └── NodeClassifier.cs     — Form / DataModule / Frame / Unit Erkennung
├── Models/                   — ProjectUnit, DependencyEdge, DependencyGraph
├── MainWindow.xaml(.cs)      — WPF-Shell, WebView2-Host, C#↔JS-Bridge
└── Web/
    ├── index.html            — WebView2-Seite
    ├── app.js                — Three.js + 3d-force-graph Logik, alle Layouts
    ├── style.css             — Dark Theme
    └── 3d-force-graph.min.js — Lokal gecacht (kein CDN)
```

**WebView2-Bridge:** `https://app.local/` → `Web/` Ordner via `SetVirtualHostNameToFolderMapping`.
C# → JS: `ExecuteScriptAsync("loadGraph({json})")`.
JS → C#: `postMessage` / `WebMessageReceived`.

## Layout-Modi

Alle Layouts pinnen Knoten via `fx/fy/fz` und synchronisieren THREE.js-Meshes manuell
über `syncMeshes()` in einem 240-frame `requestAnimationFrame`-Loop (kritisch — bei gepinnten
Knoten tickt die d3-Engine nicht und Meshes bleiben bei 0,0,0).

| Button | Modus | Funktion | Achsen |
|--------|-------|----------|--------|
| Ebenen | `layered` | Grid pro Tiefe | Tiefe→Y, XY |
| Baum   | `tree`    | DAG→echter Baum (expandToTree), Winkelsektor-Layout | Tiefe→Y, XZ-Kegel |
| 3D     | `force`   | Ringe pro Tiefe | Tiefe→Z |
| Radial | `radial`  | Konzentrische Ringe | XY |

### Baum-Modus: Knoten-Duplikation

`expandToTree()` konvertiert den DAG in einen echten Baum: Units mit mehreren Eltern
werden für jeden Ast dupliziert. Duplikate erhalten IDs wie `UnitName~~42` und tragen
`_origId` für Rückreferenz. `showInfoPanel` und `postToHost` nutzen `node._origId || node.id`.

## Knotenfärbung (Heatmap)

`GraphBuilder.cs` berechnet für jeden Knoten seine **ausgehenden** direkten uses-Einträge
(Interface + Impl), normalisiert gegen den 90. Perzentil-Wert mit einer Quadratkurve
(→ grau-dominante Verteilung) und mappt auf einen linearen Grau→Rot-Verlauf.

Startunit: `val * 125` (≈5× größerer Radius), `nodeVal`-Cap für andere Knoten = 6.

## Parser-Logik

- **DprParser:** `uses ... in 'pfad.pas'` → Map von Unit-Name → Dateipfad
- **PasParser:** State Machine entfernt `//`, `{ }`, `(* *)`, String-Literale;
  extrahiert `uses`-Blöcke aus Interface- und Implementation-Abschnitt getrennt
- **DependencyResolver:** Iterativer DFS (kein Recursion-Stack-Overflow);
  Zyklus = GRAY-Knoten beim Besuchen → Kante als `isCyclic` markiert, nicht weiter verfolgt;
  Filter: nur Units mit `unit.FileFound` (verhindert SysUtils/System-Blob)

## Persistenz & Test-Infrastruktur

- Settings: `%APPDATA%\DelphiVisualizer\settings.json` (ProjectPath, Unit, Depth)
- Auto-Load beim Start: `TryRestoreLastSession` + `_autoAnalyzeOnReady`
- Test-Projekt: `C:\Entwicklung\Delphi\lx_pdl\Programm\LCSAueg.dpr`, Unit `u_FormInformation`
- Logging: `log(msg)` in app.js → `C:\temp\graph-log.txt` via postMessage type:"log"
- Screenshot: `postMessage({type:"screenshot"})` → `C:\temp\webview.png`

## Häufige Fallstricke

| Problem | Ursache | Lösung |
|---------|---------|--------|
| Alle Knoten bei (0,0,0) | d3 tickt nicht bei gepinnten Knoten | `syncMeshes()` in rAF-Loop |
| SysUtils-Blob | Units ohne .pas-Datei im Graph | `!unit.FileFound` Filter in DependencyResolver |
| dagMode hat keinen Effekt | WebView2 ignoriert dagMode | Eigene Layouts mit fx/fy/fz |
| Info-Panel zeigt 0 uses | Baum-Duplikat-ID unbekannt | `node._origId || node.id` verwenden |
| Build schlägt fehl (.exe gesperrt) | App läuft noch | `Stop-Process -Name DelphiVisualizer` |
