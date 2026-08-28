# AcmeERP - Beispielprojekt

Synthetisches Delphi-Projekt fuer den Delphi Dependency Visualizer. Es hat keine
Fremdlogik, laesst sich aber mit Delphi 11/12 uebersetzen und erzeugt einen
absichtlich sehr grossen, stark verstrickten Abhaengigkeitsgraphen.

## Kennzahlen

| | |
|---|---|
| Units (.pas) | 523 + Programm |
| Feature-Module | 50 (je 10 Units) |
| Interface-Kanten | 718 |
| Implementation-Kanten | 1739 |
| Formulare / DataModules / Frames | 156 / 51 / 102 |

## Zirkulaere Referenz

`uAppContext` (Ordner `Common`) zieht im **interface** das Hauptformular `fMain`
herein. **Jedes** Formular benutzt `uAppContext` in seiner Implementation, und
`fMain` oeffnet umgekehrt jedes Feature-Formular. Dadurch bilden `fMain` und
saemtliche Formulare eine einzige starke Zusammenhangskomponente
(`fMain -> f<Feature> -> uAppContext -> fMain`).

Zusaetzlich paarweise Zyklen in jeder Schicht:
`uSvc<A> <-> uSvc<B>`, `uDb<A>Repo <-> uDb<B>Repo`, `uDom<A> <-> uDom<B>`.

## Oeffnen im Visualizer

**Variante A - .dpr (voller Parser-Pfad):**
`AcmeERP.dpr` oeffnen, Start-Unit `fMain`, Tiefe auf Maximum (unendlich).
`fMain` ist der Mega-Hub; die `uKernel*`-Units sind die Heatmap-Hotspots.

**Variante B - .gv (Compiler-Export):**
`AcmeERP.gv` oeffnen. Format wie der Delphi-12-Schalter `--graphviz`
(Programmname als Digraph, gruppierte Kanten, solide = interface,
`[arrowhead=open,style=dashed]` = implementation). Start-Unit `AcmeERP` oder `fMain`.

## Mit Delphi 12 selbst exportieren

```bat
dcc32 --graphviz --graphviz-exclude:System.*;Vcl.*;Winapi.*;Data.* AcmeERP.dpr
```

Erzeugt `AcmeERP.gv` (nur ueber Kommandozeile / externes MSBuild, nicht aus der IDE).

_Generiert von `SampleProject/generate_sample.py`._
