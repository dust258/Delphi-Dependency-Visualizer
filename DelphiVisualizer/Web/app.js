// Delphi Dependency Visualizer — 3D Graph Frontend

let Graph = null;
let currentData = null;
let cycleNodeSet = new Set();
let layoutMode = 'layered'; // default: pre-computed hierarchical

// ── Error / Loading helpers ──────────────────────────────

function showError(msg) {
  const el = document.getElementById('load-error');
  document.getElementById('load-error-msg').textContent = msg;
  el.classList.add('visible');
}

window.showLoading = function(text) {
  document.getElementById('loading-text').textContent = text || 'Analysiere…';
  document.getElementById('loading').classList.add('visible');
};

function hideLoading() {
  document.getElementById('loading').classList.remove('visible');
}

// ── Layout computation ───────────────────────────────────

/**
 * BFS from root, returns Map<id, depth> and Array<[ids at depth d]>
 */
function computeDepths(nodes, links, rootId) {
  const fwd = new Map(); // id -> [targetIds]
  nodes.forEach(n => fwd.set(n.id, []));
  links.forEach(l => {
    const src = l.source?.id ?? l.source;
    const tgt = l.target?.id ?? l.target;
    if (fwd.has(src)) fwd.get(src).push(tgt);
  });

  const depth = new Map();
  const byDepth = [];
  const children = new Map();  // id -> [child ids] in the BFS spanning tree
  nodes.forEach(n => children.set(n.id, []));
  depth.set(rootId, 0);
  const queue = [rootId];

  while (queue.length) {
    const id = queue.shift();
    const d = depth.get(id);
    while (byDepth.length <= d) byDepth.push([]);
    byDepth[d].push(id);
    (fwd.get(id) || []).forEach(tid => {
      if (!depth.has(tid)) {
        depth.set(tid, d + 1);
        children.get(id).push(tid);  // spanning-tree edge
        queue.push(tid);
      }
    });
  }
  return { depth, byDepth, children };
}

/**
 * Pre-compute hierarchical positions: root on top, each level below.
 * Nodes at the same depth are arranged in a circle.
 */
const NODE_REL_SIZE = 4; // must match .nodeRelSize() above

function sphereRadius(val) {
  return Math.cbrt(Math.min(val ?? 1, 6)) * NODE_REL_SIZE;
}

function seedLayeredPositions(nodes, links, rootId, pin = true) {
  const nodeById = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);

  const H_SPACING = 40;   // horizontal gap between nodes
  const ROW_SPACING = 50; // gap between rows within same depth
  const LEVEL_SPACING = 120; // extra gap between depth levels

  // Track the Y baseline for each depth level (grows as rows are added)
  let baselineY = 0;

  byDepth.forEach((ids, d) => {
    const count = ids.length;
    if (count === 0) return;

    const MAX_PER_ROW = Math.ceil(Math.sqrt(count * 2.5)); // ~square-ish grid
    const rows = Math.ceil(count / MAX_PER_ROW);
    const rowWidth = Math.min(count, MAX_PER_ROW) * H_SPACING;

    ids.forEach((id, i) => {
      const node = nodeById.get(id);
      if (!node) return;
      const row = Math.floor(i / MAX_PER_ROW);
      const col = i % MAX_PER_ROW;
      const nodesInRow = (row === rows - 1) ? count - row * MAX_PER_ROW : MAX_PER_ROW;
      const rowStart = -((nodesInRow - 1) * H_SPACING) / 2;
      node.x = rowStart + col * H_SPACING;
      node.y = baselineY - row * ROW_SPACING;
      node.z = 0;
      node.__depth = d;
      if (pin) { node.fx = node.x; node.fy = node.y; node.fz = 0; }
      else { delete node.fx; delete node.fy; delete node.fz; }
    });

    baselineY -= (rows - 1) * ROW_SPACING + LEVEL_SPACING;
  });

  const bottomY = baselineY - LEVEL_SPACING;
  const unreachable = nodes.filter(n => !depth.has(n.id));
  unreachable.forEach((n, i) => {
    n.x = (i % 20 - 10) * H_SPACING;
    n.y = bottomY - Math.floor(i / 20) * ROW_SPACING;
    n.z = 0;
    n.__depth = byDepth.length;
    if (pin) { n.fx = n.x; n.fy = n.y; n.fz = 0; }
    else { delete n.fx; delete n.fy; delete n.fz; }
  });

  return { reachable: nodes.length - unreachable.length, maxDepth: byDepth.length };
}

/**
 * 3D module tree: depth → Y axis (root on top, dependencies downward).
 * The unit's directory (storage location) determines a cluster angle in the
 * XZ plane, so units from the same module form a vertical column; columns are
 * arranged in a circle. Uses all three axes → genuinely 3D.
 */
function seedTreePositions(nodes, links, rootId, pin = true) {
  const nodeById = new Map(nodes.map(n => [n.id, n]));

  // Build children map from the expanded tree links
  const childrenOf = new Map(nodes.map(n => [n.id, []]));
  links.forEach(l => {
    const s = l.source?.id ?? l.source;
    const t = l.target?.id ?? l.target;
    if (childrenOf.has(s)) childrenOf.get(s).push(t);
  });

  // Subtree leaf count → proportional angular sector allocation
  const subtreeSize = new Map();
  const computeSize = id => {
    const ch = childrenOf.get(id) || [];
    const sz = ch.length === 0 ? 1 : ch.reduce((s, c) => s + computeSize(c), 0);
    subtreeSize.set(id, sz);
    return sz;
  };
  computeSize(rootId);

  const LEVEL_SPACING = 300;
  const RING_RADIUS   = 260; // radius per depth level → cone shape

  const setPos = (id, x, y, z, d) => {
    const n = nodeById.get(id);
    if (!n) return;
    n.x = x; n.y = y; n.z = z; n.__depth = d;
    if (pin) { n.fx = x; n.fy = y; n.fz = z; }
    else { delete n.fx; delete n.fy; delete n.fz; }
  };

  setPos(rootId, 0, 0, 0, 0);

  // BFS placement: each node owns an angular sector [aFrom, aTo]
  // Children subdivide the sector proportionally by subtree size.
  const queue = [{ id: rootId, depth: 0, aFrom: 0, aTo: 2 * Math.PI }];
  while (queue.length > 0) {
    const { id: parentId, depth, aFrom, aTo } = queue.shift();
    const ch = childrenOf.get(parentId) || [];
    if (ch.length === 0) continue;

    const totalSz = ch.reduce((s, c) => s + (subtreeSize.get(c) || 1), 0);
    const y = -(depth + 1) * LEVEL_SPACING;
    const r = (depth + 1) * RING_RADIUS;

    let aStart = aFrom;
    ch.forEach(childId => {
      const sz = subtreeSize.get(childId) || 1;
      const aSlice = (sz / totalSz) * (aTo - aFrom);
      const aMid   = aStart + aSlice / 2;
      setPos(childId, r * Math.cos(aMid), y, r * Math.sin(aMid), depth + 1);
      queue.push({ id: childId, depth: depth + 1, aFrom: aStart, aTo: aStart + aSlice });
      aStart += aSlice;
    });
  }

  return { reachable: nodes.length, maxDepth: 0 };
}

/**
 * Radial: depth = ring radius, angle distributes same-depth nodes
 */
function seedRadialPositions(nodes, links, rootId) {
  const nodeById = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);

  const SURFACE_GAP = 28;
  const ringRadii = [0];

  byDepth.forEach((ids, d) => {
    if (d === 0) {
      const root = nodeById.get(ids[0]);
      if (root) {
        root.x = 0; root.y = 0; root.z = 0; root.__depth = 0;
        root.fx = 0; root.fy = 0; root.fz = 0;
      }
      return;
    }
    const count = ids.length;
    const maxSphereR = Math.max(...ids.map(id => sphereRadius(nodeById.get(id)?.val)));
    const minArcStep = maxSphereR * 2 + SURFACE_GAP;
    const prevR = ringRadii[d - 1] ?? 0;
    const minR = prevR + maxSphereR * 2 + 60;
    const arcR = count <= 1 ? minR : Math.max(minR, (count * minArcStep) / (2 * Math.PI));
    ringRadii[d] = arcR;

    ids.forEach((id, i) => {
      const node = nodeById.get(id);
      if (!node) return;
      const angle = (2 * Math.PI * i) / count;
      // Rings in the XY plane (z=0) so the camera (looking down +Z) sees them
      node.x = arcR * Math.cos(angle);
      node.y = arcR * Math.sin(angle);
      node.z = 0;
      node.__depth = d;
      node.fx = node.x; node.fy = node.y; node.fz = node.z;
    });
  });

  const outerR = (ringRadii[ringRadii.length - 1] ?? 0) + 150;
  nodes.filter(n => !depth.has(n.id)).forEach(n => {
    const angle = Math.random() * Math.PI * 2;
    n.x = outerR * Math.cos(angle); n.y = outerR * Math.sin(angle); n.z = 0;
    n.fx = n.x; n.fy = n.y; n.fz = n.z;
  });
}

// ── Graph initialization ─────────────────────────────────

function initGraph() {
  if (typeof ForceGraph3D === 'undefined') {
    showError('ForceGraph3D nicht verfügbar — 3d-force-graph.min.js konnte nicht geladen werden.');
    return;
  }

  const container = document.getElementById('graph-container');

  try {
    Graph = ForceGraph3D()(container)
      .backgroundColor('#0A0E1A')
      .showNavInfo(false)
      .nodeLabel(node => `<div style="
          background:rgba(10,14,26,0.92);
          color:#E0E6F0;
          padding:5px 12px;
          border-radius:6px;
          border:1px solid rgba(100,181,246,0.3);
          font-size:13px;
          font-family:'Segoe UI',system-ui,sans-serif;
          pointer-events:none;
          white-space:nowrap;
        ">${node.name}<br>
        <span style="font-size:10px;color:#8899BB">${node.unitType}${node.__depth !== undefined ? ' · Tiefe ' + node.__depth : ''}</span>
        </div>`)
      .nodeColor(node => node.color)
      .nodeVal(node => node.isRoot ? (node.val ?? 1) : Math.min(node.val ?? 1, 6))
      .nodeRelSize(8)
      .nodeOpacity(1.0)
      .linkColor(link => link.isCyclic ? '#FF5252' : '#3A557F')
      .linkWidth(0)  // THREE.Line — has __lineObj we can position directly
      .linkOpacity(0.35)
      .linkDirectionalParticles(0)
      .linkCurvature(0)
      .d3AlphaDecay(0.04)
      .d3VelocityDecay(0.4)
      .onNodeClick(onNodeClick)
      .onNodeHover(onNodeHover)
      .onBackgroundClick(() => hideInfoPanel());

    const resize = () => {
      if (Graph) {
        Graph.width(container.offsetWidth || window.innerWidth);
        Graph.height(container.offsetHeight || window.innerHeight);
      }
    };
    window.addEventListener('resize', resize);
    setTimeout(resize, 100);

  } catch(e) {
    showError('initGraph Fehler: ' + e.message);
    console.error(e);
  }
}

// ── Node interaction ─────────────────────────────────────

function onNodeClick(node) {
  if (!node) return;
  showInfoPanel(node);
  const distance = 120;
  const mag = Math.hypot(node.x || 1, node.y || 1, node.z || 1);
  const distRatio = 1 + distance / mag;
  Graph.cameraPosition(
    { x: node.x * distRatio, y: node.y * distRatio, z: node.z * distRatio },
    node, 800
  );
  postToHost({ type: 'nodeClick', id: node._origId || node.id });
}

function onNodeHover(node) {
  document.body.style.cursor = node ? 'pointer' : 'default';
  if (node) showInfoPanel(node);
}

function showInfoPanel(node) {
  const links = currentData?.links || [];
  const getId = l => l.source?.id ?? l.source;
  const getTgt = l => l.target?.id ?? l.target;
  // Duplicated tree nodes carry _origId; fall back to id for non-duplicates
  const origId = node._origId || node.id;

  document.getElementById('ip-name').textContent = node.name;
  const badge = document.getElementById('ip-badge');
  badge.textContent = node.unitType;
  badge.className = `type-badge type-${node.unitType}`;
  document.getElementById('ip-iface').textContent =
    links.filter(l => getId(l) === origId && l.kind === 'interface').length;
  document.getElementById('ip-impl').textContent =
    links.filter(l => getId(l) === origId && l.kind === 'implementation').length;
  document.getElementById('ip-in').textContent =
    links.filter(l => getTgt(l) === origId).length;
  document.getElementById('ip-path').textContent = node.filePath || '';
  document.getElementById('ip-cycle').style.display =
    cycleNodeSet.has(origId) ? 'block' : 'none';
  document.getElementById('info-panel').classList.add('visible');
}

function hideInfoPanel() {
  document.getElementById('info-panel').classList.remove('visible');
}

// ── loadGraph (called from C#) ───────────────────────────

window.loadGraph = function(data) {
  hideLoading();

  if (!Graph) {
    showError('ForceGraph3D nicht initialisiert — drücke F12 für Details.');
    return;
  }

  showLoading('Berechne Layout…');

  setTimeout(() => {
    try {
      currentData = data;
      cycleNodeSet = new Set();
      (data.cycles || []).forEach(cycle =>
        cycle.forEach(name => cycleNodeSet.add(name)));

      applyLayout(layoutMode, data);

    } catch(e) {
      showError('Render-Fehler: ' + e.message);
      console.error(e);
    } finally {
      hideLoading();
    }
  }, 30);
};

// Force node meshes (and link lines) onto the computed node.x/y/z positions.
// Works even when the physics engine isn't ticking.
let _lastSyncStats = { nodes: 0, links: 0 };
let _nodeById = new Map();

function syncMeshes() {
  if (!Graph) return;
  const gd = Graph.graphData();
  let nc = 0, lc = 0;
  gd.nodes.forEach(n => {
    const obj = n.__threeObj;
    if (obj && obj.position) { obj.position.set(n.x ?? 0, n.y ?? 0, n.z ?? 0); nc++; }
  });
  gd.links.forEach(l => {
    const lo = l.__lineObj;
    if (!lo) return;
    // Resolve source/target — may still be string IDs if the engine never ticked
    const s = typeof l.source === 'object' ? l.source : _nodeById.get(l.source);
    const t = typeof l.target === 'object' ? l.target : _nodeById.get(l.target);
    if (!s || !t) return;
    const geom = lo.geometry;
    const pos = geom?.getAttribute?.('position');
    if (pos && pos.array.length >= 6) {
      pos.setXYZ(0, s.x ?? 0, s.y ?? 0, s.z ?? 0);
      pos.setXYZ(1, t.x ?? 0, t.y ?? 0, t.z ?? 0);
      pos.needsUpdate = true;
      geom.computeBoundingSphere();
      lc++;
    }
  });
  _lastSyncStats = { nodes: nc, links: lc };
}

// Center the camera on the current graph's bounding box (looking down +Z)
function centerCameraOnGraph() {
  const gd = Graph.graphData();
  if (!gd.nodes.length) return;
  const gxs = gd.nodes.map(n => n.x ?? 0);
  const gys = gd.nodes.map(n => n.y ?? 0);
  const gzs = gd.nodes.map(n => n.z ?? 0);
  const cx = (Math.min(...gxs) + Math.max(...gxs)) / 2;
  const cy = (Math.min(...gys) + Math.max(...gys)) / 2;
  const cz = (Math.min(...gzs) + Math.max(...gzs)) / 2;
  const span = Math.max(
    Math.max(...gxs) - Math.min(...gxs),
    Math.max(...gys) - Math.min(...gys),
    Math.max(...gzs) - Math.min(...gzs));
  const camZ = cz + span * 1.2 + 150;
  Graph.cameraPosition({ x: cx, y: cy, z: camZ }, { x: cx, y: cy, z: cz }, 0);
}

// Oblique view for 3D layouts. depthAxis = which axis holds the hierarchy:
//  'y' (tree): camera mostly to the side so the vertical column stays vertical.
//  'z' (force): camera above/side/front so the into-screen depth is visible.
function obliqueCameraOnGraph(depthAxis) {
  const gd = Graph.graphData();
  if (!gd.nodes.length) return;
  const xs = gd.nodes.map(n => n.x ?? 0);
  const ys = gd.nodes.map(n => n.y ?? 0);
  const zs = gd.nodes.map(n => n.z ?? 0);
  const cx = (Math.min(...xs) + Math.max(...xs)) / 2;
  const cy = (Math.min(...ys) + Math.max(...ys)) / 2;
  const cz = (Math.min(...zs) + Math.max(...zs)) / 2;
  const span = Math.max(
    Math.max(...xs) - Math.min(...xs),
    Math.max(...ys) - Math.min(...ys),
    Math.max(...zs) - Math.min(...zs)) + 300;

  const off = depthAxis === 'y'
    ? { x: span * 0.85, y: span * 0.25, z: span * 0.95 }   // side view, slight elevation
    : { x: span * 0.75, y: span * 0.55, z: span * 0.85 };  // above/front view
  Graph.cameraPosition(
    { x: cx + off.x, y: cy + off.y, z: cz + off.z },
    { x: cx, y: cy, z: cz }, 0);
}

// 3D layered layout: each depth becomes a concentric ring, and depth is mapped
// to the Z axis — so the hierarchy extends INTO the screen. Deterministic and
// fast (unlike force-directed, which collapses on dense graphs).
function seed3DPositions(nodes, links, rootId) {
  const nodeById = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);
  const Z_SPACING = 220;
  const SURFACE_GAP = 30;

  byDepth.forEach((ids, d) => {
    const count = ids.length;
    if (count === 0) return;
    const maxR = Math.max(...ids.map(id => sphereRadius(nodeById.get(id)?.val)));
    const step = maxR * 2 + SURFACE_GAP;
    const radius = count === 1 ? 0 : Math.max(step, (count * step) / (2 * Math.PI));
    ids.forEach((id, i) => {
      const node = nodeById.get(id);
      if (!node) return;
      const angle = count === 1 ? 0 : (2 * Math.PI * i) / count;
      node.x = radius * Math.cos(angle);
      node.y = radius * Math.sin(angle);
      node.z = -d * Z_SPACING;
      node.__depth = d;
      node.fx = node.x; node.fy = node.y; node.fz = node.z;
    });
  });

  const maxD = byDepth.length;
  nodes.filter(n => !depth.has(n.id)).forEach((n, i) => {
    const a = (2 * Math.PI * i) / 20;
    n.x = 300 * Math.cos(a); n.y = 300 * Math.sin(a); n.z = -maxD * Z_SPACING;
    n.fx = n.x; n.fy = n.y; n.fz = n.z;
  });
}

// Expand DAG → true tree: duplicate nodes that appear in multiple branches.
// Cycle edges (back-edges within the current DFS path) are dropped.
function expandToTree(nodes, links, rootId) {
  const MAX_NODES = 20000;
  const origById = new Map(nodes.map(n => [n.id, n]));

  const fwd = new Map(nodes.map(n => [n.id, []]));
  links.forEach(l => {
    const s = l.source?.id ?? l.source;
    const t = l.target?.id ?? l.target;
    if (fwd.has(s)) fwd.get(s).push(t);
  });

  const treeNodes = [];
  const treeLinks = [];
  let uid = 0;

  function visit(origId, parentTreeId, ancestors) {
    if (treeNodes.length >= MAX_NODES) return;
    if (ancestors.has(origId)) return;           // back-edge → cycle, stop here
    const orig = origById.get(origId);
    if (!orig) return;

    const treeId = (parentTreeId === null) ? origId : `${origId}~~${++uid}`;
    treeNodes.push({ ...orig, id: treeId, _origId: origId });

    if (parentTreeId !== null)
      treeLinks.push({ source: parentTreeId, target: treeId, color: '#3A557F', isCyclic: false, kind: 'interface' });

    const next = new Set(ancestors);
    next.add(origId);
    (fwd.get(origId) || []).forEach(childId => visit(childId, treeId, next));
  }

  visit(rootId, null, new Set());
  return { nodes: treeNodes, links: treeLinks };
}

function applyLayout(mode, data) {
  data = data || currentData;
  if (!data) return;

  layoutMode = mode;
  let nodes = data.nodes;
  let links = data.links;

  // Tree mode: expand shared nodes so each branch gets its own copy
  if (mode === 'tree') {
    const expanded = expandToTree(nodes, links, data.rootUnit);
    nodes = expanded.nodes;
    links = expanded.links;
  }

  log(`applyLayout mode=${mode} nodes=${nodes.length} links=${links.length} cycleNodes=${cycleNodeSet.size}`);
  _nodeById = new Map(nodes.map(n => [n.id, n]));

  // Pinned layouts: compute positions ourselves, then glue meshes to them.
  if (mode === 'radial')       seedRadialPositions(nodes, links, data.rootUnit);
  else if (mode === 'tree')    seedTreePositions(nodes, links, data.rootUnit, true);
  else if (mode === 'force')   seed3DPositions(nodes, links, data.rootUnit);
  else                          seedLayeredPositions(nodes, links, data.rootUnit, true);

  // No dagMode. Pins (fx/fy/fz) hold nodes; syncMeshes glues meshes & links.
  Graph.dagMode(null);
  Graph.d3Force('center', null);
  Graph.d3Force('charge', null);
  Graph.d3Force('link').strength(0);
  Graph.cooldownTicks(Infinity);
  Graph.cooldownTime(15000);

  Graph.graphData({ nodes, links });

  const is3D = (mode === 'force' || mode === 'tree');
  setTimeout(() => {
    try {
      syncMeshes();
      let frames = 0;
      const tick = () => { syncMeshes(); if (++frames < 240) requestAnimationFrame(tick); };
      requestAnimationFrame(tick);
      if (mode === 'tree')       obliqueCameraOnGraph('y');  // depth on Y → view from side
      else if (mode === 'force') obliqueCameraOnGraph('z');  // depth on Z
      else                       centerCameraOnGraph();
    } catch (e) {
      log(`Layout ${mode} ERROR: ${e.message}`);
    }
  }, 1200);

  // Stats & overlays
  const stats = data.stats || {};
  document.getElementById('st-units').textContent = stats.unitCount ?? nodes.length;
  document.getElementById('st-edges').textContent = stats.edgeCount ?? links.length;
  document.getElementById('st-cycles').textContent = stats.cycleCount ?? data.cycles?.length ?? 0;
  document.getElementById('stats-overlay').classList.add('visible');
  document.getElementById('legend').classList.add('visible');
  buildCyclePanel(data.cycles || []);
}

// ── Public API (called from C#) ──────────────────────────

window.highlightNode = function(nodeId) {
  if (!Graph) return;
  const node = Graph.graphData().nodes.find(n => n.id === nodeId);
  if (node) onNodeClick(node);
};

window.setLayoutMode = function(mode) {
  applyLayout(mode);
};


window.resetCamera = function() {
  if (Graph) Graph.zoomToFit(600, 60);
};

// ── Cycle panel ──────────────────────────────────────────

function buildCyclePanel(cycles) {
  const panel = document.getElementById('cycle-panel');
  const list = document.getElementById('cycle-list');
  list.innerHTML = '';
  if (!cycles.length) { panel.classList.remove('visible'); return; }
  cycles.forEach((cycle, i) => {
    const item = document.createElement('div');
    item.className = 'cycle-item';
    item.textContent = `${i + 1}. ${cycle.join(' → ')}`;
    item.onclick = () => {
      const node = Graph?.graphData().nodes.find(n => n.id === cycle[0]);
      if (node) onNodeClick(node);
    };
    list.appendChild(item);
  });
  panel.classList.add('visible');
}

function postToHost(msg) {
  try {
    if (window.chrome?.webview)
      window.chrome.webview.postMessage(JSON.stringify(msg));
  } catch (_) {}
}

function log(msg) {
  console.log(msg);
  postToHost({ type: 'log', msg: String(msg) });
}

// ── Bootstrap ────────────────────────────────────────────

initGraph();
postToHost({ type: 'ready' });
