#!/usr/bin/env python3
"""Generates small Delphi projects, each exercising one circular-reference
pattern, under SampleProject/Scenarios/<name>/<name>.dpr.

Each scenario: root unit, units as {name: (interface_uses, implementation_uses)},
plus a note and the depth to analyse with (10 = unlimited).
Run:  python generate_scenarios.py
"""
import json
import shutil
from pathlib import Path

OUT = Path(__file__).parent / "Scenarios"


def ring(prefix, n, kind="interface"):
    names = [f"{prefix}{i}" for i in range(n)]
    units = {}
    for i, nm in enumerate(names):
        nxt = names[(i + 1) % n]
        units[nm] = ([nxt], []) if kind == "interface" else ([], [nxt])
    return names[0], units


SCENARIOS = {}

SCENARIOS["direct_pair"] = dict(
    note="A <-> B, both in interface uses (illegal in Delphi, must still be detected)",
    root="UnitA", depth=10, min_cycles=1,
    units={"UnitA": (["UnitB"], []), "UnitB": (["UnitA"], [])})

SCENARIOS["impl_cycle"] = dict(
    note="A uses B in interface, B uses A in implementation (the legal Delphi pattern)",
    root="UnitA", depth=10, min_cycles=1,
    units={"UnitA": (["UnitB"], []), "UnitB": ([], ["UnitA"])})

SCENARIOS["self_reference"] = dict(
    note="Unit uses itself",
    root="UnitA", depth=10, min_cycles=1,  # reported as "UnitA -> UnitA"
    units={"UnitA": (["UnitA", "UnitB"], []), "UnitB": ([], [])})

SCENARIOS["triangle"] = dict(
    note="A -> B -> C -> A",
    root="UnitA", depth=10, min_cycles=1,
    units={"UnitA": (["UnitB"], []), "UnitB": (["UnitC"], []), "UnitC": ([], ["UnitA"])})

root, units = ring("Ring", 12)
SCENARIOS["long_ring"] = dict(
    note="12 units in one interface ring", root=root, depth=10, min_cycles=1, units=units)

SCENARIOS["two_cycles_shared_node"] = dict(
    note="Two cycles sharing Core: Core->A->Core and Core->B->C->Core",
    root="Core", depth=10, min_cycles=2,
    units={"Core": (["UnitA", "UnitB"], []),
           "UnitA": ([], ["Core"]),
           "UnitB": (["UnitC"], []),
           "UnitC": ([], ["Core"])})

hub_units = {"Hub": ([f"Spoke{i}" for i in range(6)], [])}
for i in range(6):
    hub_units[f"Spoke{i}"] = ([], ["Hub"])
SCENARIOS["hub_and_spokes"] = dict(
    note="Hub uses 6 spokes, every spoke uses Hub back (6 cycles through one node)",
    root="Hub", depth=10, min_cycles=6, units=hub_units)

SCENARIOS["nested_sccs"] = dict(
    note="Two separate cycles (A<->B, C<->D) connected by a one-way bridge",
    root="UnitA", depth=10, min_cycles=2,
    units={"UnitA": (["UnitB"], []), "UnitB": ([], ["UnitA", "Bridge"]),
           "Bridge": (["UnitC"], []),
           "UnitC": (["UnitD"], []), "UnitD": ([], ["UnitC"])})

SCENARIOS["case_mismatch"] = dict(
    note="uses clauses spell units with different casing than the files/dpr "
         "(regression test: edges must not point to non-existent node ids)",
    root="MainForm", depth=10, min_cycles=1,
    units={"MainForm": (["datamodule1", "UTILS"], []),
           "DataModule1": (["utils"], ["MAINFORM"]),
           "Utils": ([], ["mainform"])})

SCENARIOS["depth_order"] = dict(
    note="Depth-limit regression: D is reached first via Root->A->C->D (depth 3, "
         "cut off) and also via Root->B->D (depth 2). With depth=3 F (child of D) "
         "must still be present.",
    root="Root", depth=3, min_cycles=0,
    units={"Root": (["UnitA", "UnitB"], []),
           "UnitA": (["UnitC"], []), "UnitC": (["UnitD"], []),
           "UnitB": (["UnitD"], []),
           "UnitD": (["UnitF"], []), "UnitF": ([], [])},
    must_contain=["UnitF"])

SCENARIOS["tricky_syntax"] = dict(
    note="Commented-out / string-embedded uses that must NOT create edges, "
         "plus a real cycle A<->B",
    root="UnitA", depth=10, min_cycles=1,
    raw={"UnitA": """unit UnitA;

interface

uses
  // Ghost1,
  UnitB, {Ghost2,} (* Ghost3, *) System.SysUtils;

const
  Msg = 'uses Ghost4;';

implementation

end.
""",
         "UnitB": """unit UnitB;

interface

implementation

uses
  UnitA;

end.
""",
         "Ghost1": "unit Ghost1;\ninterface\nimplementation\nend.\n",
         "Ghost2": "unit Ghost2;\ninterface\nimplementation\nend.\n",
         "Ghost3": "unit Ghost3;\ninterface\nimplementation\nend.\n",
         "Ghost4": "unit Ghost4;\ninterface\nimplementation\nend.\n"},
    must_not_contain=["Ghost1", "Ghost2", "Ghost3", "Ghost4"],
    dpr_units=["UnitA", "UnitB", "Ghost1", "Ghost2", "Ghost3", "Ghost4"])


def unit_text(name, iface, impl):
    s = f"unit {name};\n\ninterface\n\n"
    if iface:
        s += "uses\n  " + ",\n  ".join(iface) + ";\n\n"
    s += "implementation\n\n"
    if impl:
        s += "uses\n  " + ",\n  ".join(impl) + ";\n\n"
    return s + "end.\n"


def main():
    if OUT.exists():
        shutil.rmtree(OUT)
    manifest = {}
    for name, sc in SCENARIOS.items():
        d = OUT / name
        d.mkdir(parents=True)
        files = sc.get("raw") or {u: unit_text(u, *v) for u, v in sc["units"].items()}
        for u, text in files.items():
            (d / f"{u}.pas").write_text(text, encoding="utf-8")
        dpr_units = sc.get("dpr_units") or list(files)
        uses = ",\n  ".join(f"{u} in '{u}.pas'" for u in dpr_units)
        (d / f"{name}.dpr").write_text(
            f"program {name};\n\nuses\n  {uses};\n\nbegin\nend.\n", encoding="utf-8")
        manifest[name] = {k: sc.get(k) for k in
                          ("note", "root", "depth", "min_cycles", "must_contain", "must_not_contain")}
        manifest[name]["dpr"] = str((d / f"{name}.dpr").resolve())
    (OUT / "manifest.json").write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    print(f"{len(SCENARIOS)} scenarios written to {OUT}")


if __name__ == "__main__":
    main()
