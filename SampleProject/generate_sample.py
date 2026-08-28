#!/usr/bin/env python3
"""
Generator for the AcmeERP sample Delphi project.

Emits a compilable Delphi source tree (.dpr / .pas / .dfm) plus a hand-rolled
AcmeERP.gv that matches the format the Delphi 12+ compiler produces with the
--graphviz switch.

The graph is intentionally large and tangled:
  * ~50 business "feature" modules, 10 units each (domain / repo / service /
    datamodule / 2 frames / 3 forms)
  * a mega-hub main form (fMain) that opens every feature form
  * a cross-cutting unit uAppContext whose interface pulls in fMain; EVERY form
    uses it in its implementation -> fMain <-> <every form> circular references
  * paired service / repository / domain cross-uses -> dozens more cycles
  * the six uKernel* units are used almost everywhere -> heatmap hotspots

Run:  python generate_sample.py
Output goes to  ./AcmeERP/  next to this script (dir is wiped first).
"""

import os
import shutil
import textwrap

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "AcmeERP")

# Standard-library units that appear in uses clauses for realism. The visualizer
# correctly drops them (no .pas on disk => FileFound = false).
RTL = ["System.SysUtils", "System.Classes"]
VCL = ["Vcl.Forms", "Vcl.Controls", "Vcl.Dialogs"]

# 50 business domains -> one feature module each.
FEATURES = [
    "Customer", "Order", "Product", "Invoice", "Shipment", "Payment", "Supplier",
    "Warehouse", "Category", "Discount", "Tax", "Currency", "Contract", "Quotation",
    "Return", "Refund", "Inventory", "Stock", "Pricing", "Campaign", "Lead",
    "Opportunity", "Contact", "Account", "Ticket", "Project", "Task", "Timesheet",
    "Expense", "Budget", "Ledger", "Journal", "Asset", "Depreciation", "Payroll",
    "Employee", "Department", "Role", "Permission", "Notification", "Report",
    "Dashboard", "Audit", "Setting", "Import", "Export", "Batch", "Schedule",
    "Reminder", "Document",
]

# ---------------------------------------------------------------------------
# Unit model:  name -> [folder, kind, interface_uses, implementation_uses]
#   kind: "unit" | "form" | "datamodule" | "frame"
# Lists (not tuples) so the cross-link pass below can append.
# ---------------------------------------------------------------------------
U = {}

def unit(name, folder, kind, iface, impl):
    U[name] = [folder, kind, list(iface), list(impl)]

# ---- Common / kernel (cross-cutting, high in-degree -> heatmap hotspots) ----
unit("uKernelExceptions", "Common", "unit", [], [])
unit("uKernelUtils",      "Common", "unit", [], ["uKernelConfig", "uKernelExceptions"])
unit("uKernelConfig",     "Common", "unit", ["uKernelExceptions"], ["uKernelUtils"])   # <-> uKernelUtils
unit("uKernelLog",        "Common", "unit", ["uKernelConfig"], ["uKernelUtils"])
unit("uKernelEvents",     "Common", "unit", [], ["uKernelLog"])
unit("uKernelContainer",  "Common", "unit", ["uKernelExceptions"], ["uKernelLog", "uKernelConfig"])

# ---- Domain / Data / Services base ----
unit("uDomTypes",     "Domain", "unit", [], [])
unit("uDomAddress",   "Domain", "unit", ["uDomTypes"], ["uKernelUtils"])
unit("uDomUser",      "Domain", "unit", ["uDomTypes"], ["uKernelUtils"])
unit("uDbConnection", "Data", "unit", ["uKernelConfig"], ["uKernelLog", "uKernelExceptions"])
unit("uDbRepository", "Data", "unit", ["uDbConnection", "uDomTypes"], ["uKernelLog"])
unit("uDbUserRepo",   "Data", "unit", ["uDbRepository", "uDomUser"], ["uKernelUtils"])
unit("uSvcAuth",         "Services", "unit", ["uDomUser"], ["uDbUserRepo", "uKernelLog", "uKernelConfig"])
unit("uSvcNotification", "Services", "unit", ["uDomTypes"], ["uKernelLog", "uKernelEvents"])
unit("uSvcReport",       "Services", "unit", ["uDomTypes"], ["uKernelLog", "uKernelUtils"])

unit("frmAuditLog", "Frames", "frame", ["uDomTypes"], ["uKernelLog", "uKernelEvents"])
unit("frmAddress",  "Frames", "frame", ["uDomAddress"], ["uKernelUtils"])
unit("dmMain", "DataModules", "datamodule", ["uDbConnection"],
     ["uSvcAuth", "uKernelLog", "uKernelConfig", "uKernelContainer"])

# The cross-cutting unit that references the main form. Every form uses it
# (implementation) -> combined with fMain opening every form this makes fMain
# and all forms one big strongly-connected component.
unit("uAppContext", "Common", "unit", ["fMain"], ["uKernelLog", "uKernelConfig"])

# ---- Feature modules: 10 units each ---------------------------------------
for i, F in enumerate(FEATURES):
    nxt = FEATURES[(i + 1) % len(FEATURES)]
    dom, domd = f"uDom{F}", f"uDom{F}Detail"
    repo, svc = f"uDb{F}Repo", f"uSvc{F}"
    dm = f"dm{F}"
    flist, fedit = f"frm{F}List", f"frm{F}Edit"
    form, formE, formR = f"f{F}", f"f{F}Edit", f"f{F}Report"

    unit(dom,   "Domain", "unit", ["uDomTypes"], ["uKernelUtils"])
    unit(domd,  "Domain", "unit", ["uDomTypes", dom], ["uKernelUtils"])
    unit(repo,  "Data", "unit", ["uDbRepository", dom], ["uKernelUtils"])
    unit(svc,   "Services", "unit", [dom, domd], [repo, "uKernelLog", "uKernelEvents"])
    unit(dm,    "DataModules", "datamodule", ["uDbConnection"], [svc, repo, "uKernelLog"])
    unit(flist, "Frames", "frame", [dom], [dm, svc, "uKernelUtils", "uKernelEvents"])
    unit(fedit, "Frames", "frame", [domd], [dm, "uKernelUtils"])
    unit(form,  "Forms", "form", [flist],
         [formE, formR, dm, svc, "uAppContext", "uKernelUtils"])
    unit(formE, "Forms", "form", [domd, fedit],
         [svc, dm, "uAppContext", "uKernelExceptions"])
    unit(formR, "Forms", "form", ["uDomTypes"],
         [dm, svc, "uAppContext", "frmAuditLog", "uKernelUtils"])

# ---- Paired cross-uses -> guaranteed 2-cycles in each layer --------------
for i in range(0, len(FEATURES) - 1, 2):
    a, b = FEATURES[i], FEATURES[i + 1]
    U[f"uSvc{a}"][3].append(f"uSvc{b}")          # service <-> service
    U[f"uSvc{b}"][3].append(f"uSvc{a}")
    U[f"uDb{a}Repo"][3].append(f"uDb{b}Repo")    # repo <-> repo
    U[f"uDb{b}Repo"][3].append(f"uDb{a}Repo")
for i in range(0, len(FEATURES) - 1, 3):
    a, b = FEATURES[i], FEATURES[i + 1]
    U[f"uDom{a}"][3].append(f"uDom{b}")          # domain <-> domain
    U[f"uDom{b}"][3].append(f"uDom{a}")

# ---- Shared forms ------------------------------------------------------------
unit("fSplash",   "Forms", "form", [], ["uKernelConfig"])
unit("fAbout",    "Forms", "form", [], ["uKernelConfig", "uKernelUtils", "uAppContext"])
unit("fLogin",    "Forms", "form", ["uDomUser"],
     ["uSvcAuth", "dmMain", "uAppContext", "uKernelConfig", "uKernelExceptions"])
unit("fSettings", "Forms", "form", [],
     ["dmMain", "uAppContext", "uKernelConfig", "uKernelContainer", "uKernelUtils"])
unit("fUserAdmin", "Forms", "form", ["uDomUser"],
     ["dmMain", "uSvcAuth", "uDbUserRepo", "uAppContext", "uKernelUtils"])

# ---- Main form: opens every feature form -> mega hub + big cycle -----------
unit("fMain", "Forms", "form", ["uKernelEvents"],
     ["fLogin", "fSettings", "fUserAdmin", "fAbout", "dmMain", "uSvcAuth",
      "uSvcNotification", "uKernelLog", "uKernelConfig", "uKernelContainer",
      "uKernelUtils"] + [f"f{F}" for F in FEATURES])

# .dpr uses order (roughly compile order per layer)
LAYER_ORDER = ["Common", "Domain", "Data", "Services", "DataModules", "Frames", "Forms"]
DPR_ORDER = [n for layer in LAYER_ORDER for n in U if U[n][0] == layer]

CLASS_BASE = {"form": "TForm", "datamodule": "TDataModule", "frame": "TFrame"}


def rel_pas(name):
    return f"{U[name][0]}\\{name}.pas"


def write(path, content):
    full = os.path.join(OUT, path)
    os.makedirs(os.path.dirname(full), exist_ok=True)
    with open(full, "w", encoding="utf-8", newline="\r\n") as f:
        f.write(content)


def emit_unit(name):
    folder, kind, iface, impl = U[name]
    iface_list = list(iface)
    impl_list = list(impl)

    # add RTL/VCL noise so the sample resembles real code
    if kind in ("form", "frame"):
        iface_list = RTL + VCL + iface_list
    elif kind == "datamodule":
        iface_list = RTL + ["Data.DB"] + iface_list
    else:
        iface_list = RTL + iface_list

    iface_uses = "\n  " + ",\n  ".join(iface_list) + ";" if iface_list else ";"
    impl_uses = ("\nuses\n  " + ",\n  ".join(impl_list) + ";\n") if impl_list else "\n"

    if kind in CLASS_BASE:
        base = CLASS_BASE[kind]
        cls = "T" + name
        type_decl = textwrap.dedent(f"""\
        type
          {cls} = class({base})
          private
            {{ private declarations }}
          public
            {{ public declarations }}
          end;

        var
          {name}: {cls};
        """)
        impl_directive = "{$R *.dfm}\n\n"
    else:
        cls = "T" + name[1:] if name.startswith("u") else "T" + name
        type_decl = textwrap.dedent(f"""\
        type
          {cls} = class
          public
            constructor Create;
            destructor Destroy; override;
          end;
        """)
        impl_directive = ""

    body = f"""unit {name};

interface

uses{iface_uses}

{type_decl}
implementation
{impl_uses}
{impl_directive}"""

    if kind not in CLASS_BASE:
        body += textwrap.dedent(f"""\
        {{ {cls} }}

        constructor {cls}.Create;
        begin
          inherited Create;
        end;

        destructor {cls}.Destroy;
        begin
          inherited Destroy;
        end;

        """)

    body += "end.\n"
    write(rel_pas(name).replace("\\", "/"), body)

    if kind in CLASS_BASE:
        emit_dfm(name, kind)


def emit_dfm(name, kind):
    cls = "T" + name
    if kind == "datamodule":
        dfm = f"object {name}: {cls}\n  Height = 480\n  Width = 640\nend\n"
    elif kind == "frame":
        dfm = f"object {name}: {cls}\n  Left = 0\n  Top = 0\n  Width = 640\n  Height = 480\n  TabOrder = 0\nend\n"
    else:
        dfm = (f"object {name}: {cls}\n  Left = 0\n  Top = 0\n"
               f"  Caption = '{name}'\n  ClientHeight = 600\n  ClientWidth = 900\nend\n")
    write(f"{U[name][0]}/{name}.dfm", dfm)


def emit_dpr():
    lines = ["program AcmeERP;", "", "uses", "  Vcl.Forms,"]
    for i, n in enumerate(DPR_ORDER):
        sep = "," if i < len(DPR_ORDER) - 1 else ";"
        lines.append(f"  {n} in '{rel_pas(n)}'{sep}")
    lines += [
        "",
        "{$R *.res}",
        "",
        "begin",
        "  Application.Initialize;",
        "  Application.MainFormOnTaskBar := True;",
        "  Application.CreateForm(TdmMain, dmMain);",
        "  Application.CreateForm(TfMain, fMain);",
        "  Application.Run;",
        "end.",
        "",
    ]
    write("AcmeERP.dpr", "\n".join(lines))


def emit_gv():
    """Mimics `dcc32 --graphviz --graphviz-exclude:System.*;Vcl.*;Winapi.*;Data.*`."""
    out = ["digraph AcmeERP {"]
    out.append("      AcmeERP -> { " + " ".join(DPR_ORDER) + " }")
    for n in DPR_ORDER:
        _, _, iface, impl = U[n]
        if iface:
            out.append(f"      {n} -> {{ {' '.join(iface)} }}")
        if impl:
            out.append(f"      {n} -> {{ {' '.join(impl)} }} [arrowhead=open,style=dashed]")
        if not iface and not impl:
            out.append(f"      {n}")
    out.append("}")
    write("AcmeERP.gv", "\n".join(out) + "\n")


def emit_readme():
    n_units = len(U)
    n_iface = sum(len(v[2]) for v in U.values())
    n_impl = sum(len(v[3]) for v in U.values())
    n_form = sum(1 for v in U.values() if v[1] == "form")
    n_dm = sum(1 for v in U.values() if v[1] == "datamodule")
    n_frame = sum(1 for v in U.values() if v[1] == "frame")
    txt = f"""# AcmeERP - Beispielprojekt

Synthetisches Delphi-Projekt fuer den Delphi Dependency Visualizer. Es hat keine
Fremdlogik, laesst sich aber mit Delphi 11/12 uebersetzen und erzeugt einen
absichtlich sehr grossen, stark verstrickten Abhaengigkeitsgraphen.

## Kennzahlen

| | |
|---|---|
| Units (.pas) | {n_units} + Programm |
| Feature-Module | {len(FEATURES)} (je 10 Units) |
| Interface-Kanten | {n_iface} |
| Implementation-Kanten | {n_impl} |
| Formulare / DataModules / Frames | {n_form} / {n_dm} / {n_frame} |

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
"""
    write("README.md", txt)


def main():
    if os.path.isdir(OUT):
        shutil.rmtree(OUT)
    for name in U:
        emit_unit(name)
    emit_dpr()
    emit_gv()
    emit_readme()
    files = sum(len(fs) for _, _, fs in os.walk(OUT))
    print(f"AcmeERP sample written to {OUT}  ({len(U)} units, {files} files)")


if __name__ == "__main__":
    main()
