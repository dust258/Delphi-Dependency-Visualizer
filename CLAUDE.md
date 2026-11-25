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
│   ├── GraphVizParser.cs     — .gv-Datei (Delphi 12+ --graphviz) → Unit-Liste
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
- **GraphVizParser:** Importiert `.gv`/`.dot`-Dateien aus dem Delphi 12+ Compiler-Switch
  `--graphviz` (nur CLI/MSBuild-Build, nicht IDE). Kanten sind vom Compiler bereits
  aufgelöst → kein Suchpfad-Problem, kein `PasParser`-Aufruf nötig (Uses-Listen werden
  direkt aus den `.gv`-Kanten befüllt). Solid-Kanten = Interface, `style=dashed`/
  `arrowhead=open` = Implementation. Der Digraph-Name wird als Pseudo-Knoten mit
  `UnitType = "Program"` angelegt. v1 bewusst ohne Datei-Auflösung: alle Units haben
  `FilePath = ""`, `FileFound = true`, Klassifizierung bleibt generisch `"Unit"`
  (`NodeClassifier.ClassifyAll` wird für `.gv`-Imports übersprungen, siehe `MainWindow.LoadProject`).
- **DependencyResolver:** Iterativer DFS (kein Recursion-Stack-Overflow);
  Zyklus = GRAY-Knoten beim Besuchen → Kante als `isCyclic` markiert, nicht weiter verfolgt;
  Filter: nur Units mit `unit.FileFound` (verhindert SysUtils/System-Blob)

## Persistenz & Test-Infrastruktur

- Settings: `%APPDATA%\DelphiVisualizer\settings.json` (ProjectPath, Unit, Depth)
- Auto-Load beim Start: `TryRestoreLastSession` + `_autoAnalyzeOnReady`
- Beispielprojekt (mitgeliefert): `SampleProject/AcmeERP/` — ~523 synthetische Units
  (50 Feature-Module à 10 Units), Mega-Hub `fMain`, ~69 Zyklen. `uAppContext` (interface
  `uses fMain`) wird von jedem Formular benutzt → `fMain` + alle Formulare bilden eine
  große SCC. Wird via `.csproj`-`<Content>` nach `bin\...\SampleProject\` und ins
  Deployment kopiert. Regenerierbar mit `SampleProject/generate_sample.py` (Graph als
  Datenmodell, `FEATURES`-Liste steuert die Größe; löscht `AcmeERP/` vorher).
  `AcmeERP.gv` ist handgeschrieben im Delphi-12-`--graphviz`-Format.
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

## MCP-Steuerung (Debug/Automation)

Die App hat einen optionalen, eingebauten MCP-Server (`Services/McpServer.cs`, Tools in
`MainWindow.Mcp.cs`). Er ist **standardmäßig aus** und lauscht nur auf `127.0.0.1`
(Origin-Check gegen Browser-Zugriffe). Start:

```bat
bin\Release\net8.0-windows\DelphiVisualizer.exe --mcp          :: Port 39217
bin\Release\net8.0-windows\DelphiVisualizer.exe --mcp=40000    :: eigener Port
set DELPHIVIZ_MCP=1                                            :: alternativ per Env
```

`.mcp.json` im Projektstamm verweist auf `http://127.0.0.1:39217/mcp` (Streamable HTTP).
Tools: `get_state`, `open_project`, `list_units`, `analyze`, `get_graph`, `set_layout`,
`set_filter`, `select_unit`, `reset_camera`, `screenshot`, `eval_js` (DevTools
`Runtime.evaluate`, awaitet Promises), `get_log` (app.js-`log()`, JS-Fehler,
`console.error`, Analyse-/Ladefehler). Im MCP-Modus erscheinen keine modalen
MessageBoxen; Fehler landen in `get_log` / `lastError`.
`eval_js` führt beliebiges JS aus — deshalb nur lokal und nur auf ausdrücklichen Start.
