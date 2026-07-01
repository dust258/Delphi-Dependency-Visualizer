// Delphi Dependency Visualizer — 3D Graph Frontend

let Graph = null;
let currentData = null;
let cycleNodeSet = new Set();
let layoutMode = 'force';

let selectedNode = null;
const highlightNodeIds = new Set();

let visFilter = { formsOnly: false, sameDir: false, usesFiltered: false };
let _maxNodes = 20000;

// ── Internationalisierung ────────────────────────────────────
let _t = {};

window.setLanguage = function(lang, dict) {
  _t = dict || {};
  applyTranslations();
};

function t(key, ...args) {
  let s = _t[key] ?? key;
  args.forEach((a, i) => s = s.replace(`{${i}}`, String(a)));
  return s;
}

function applyTranslations() {
  document.querySelectorAll('[data-i18n]').forEach(el =>
    el.textContent = t(el.dataset.i18n));
  document.querySelectorAll('[data-i18n-title]').forEach(el =>
    el.title = t(el.dataset.i18nTitle));
}

// ── Web Worker für Layout-Berechnung ────────────────────────
const _layoutWorker = new Worker('layoutWorker.js');
_layoutWorker.onerror = ev => {
  log('Worker error: ' + ev.message);
  showError(t('error.workerLoad', ev.message));
};
_layoutWorker.onmessage = ev => {
  if (ev.data.error) {
    log('Worker error: ' + ev.data.error);
    showError(t('error.workerFailed', ev.data.error));
    hideLoading();
    return;
  }
  _applyLayoutResult(ev.data.mode, ev.data.nodes, ev.data.links);
};

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

  // Build children map from expanded tree links
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

  // Pass 1: count nodes per depth (BFS) to compute required radius per level
  const depthOf = new Map([[rootId, 0]]);
  const bfsQ = [rootId];
  while (bfsQ.length) {
    const id = bfsQ.shift();
    (childrenOf.get(id) || []).forEach(c => {
      if (!depthOf.has(c)) { depthOf.set(c, depthOf.get(id) + 1); bfsQ.push(c); }
    });
  }
  const nodesPerDepth = new Map();
  nodes.forEach(n => {
    const d = depthOf.get(n.id) ?? 0;
    nodesPerDepth.set(d, (nodesPerDepth.get(d) || 0) + 1);
  });

  // Radius: grow with both depth and node count, capped to stay within Three.js range
  const MIN_ARC     = 20;   // minimum arc per node (units)
  const BASE_R      = 400;  // minimum radius at depth 1
  const MAX_R       = 9000; // hard cap — beyond this Three.js camera can't see nodes
  const radiusAt    = d => Math.min(MAX_R, Math.max(BASE_R * d, ((nodesPerDepth.get(d) || 1) * MIN_ARC) / (2 * Math.PI)));
  const LEVEL_SPACING = 450;

  const setPos = (id, x, y, z, d) => {
    const n = nodeById.get(id);
    if (!n) return;
    n.x = x; n.y = y; n.z = z; n.__depth = d;
    if (pin) { n.fx = x; n.fy = y; n.fz = z; }
    else { delete n.fx; delete n.fy; delete n.fz; }
  };

  setPos(rootId, 0, 0, 0, 0);

  // Pass 2: BFS placement — each node owns a sector [aFrom, aTo]
  // Children subdivide the sector proportionally by subtree size.
  const queue = [{ id: rootId, depth: 0, aFrom: 0, aTo: 2 * Math.PI }];
  while (queue.length > 0) {
    const { id: parentId, depth, aFrom, aTo } = queue.shift();
    const ch = childrenOf.get(parentId) || [];
    if (ch.length === 0) continue;

    const totalSz = ch.reduce((s, c) => s + (subtreeSize.get(c) || 1), 0);
    const y = -(depth + 1) * LEVEL_SPACING;
    const r = radiusAt(depth + 1);

    let aStart = aFrom;
    ch.forEach(childId => {
      const sz    = subtreeSize.get(childId) || 1;
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
    showError(t('error.libNotInit'));
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
        <span style="font-size:10px;color:#8899BB">${node.unitType}${node.__depth !== undefined ? ' · ' + t('tooltip.depth', node.__depth) : ''}</span>
        </div>`)
      .nodeColor(node => node.color)
      .nodeVal(node => node.isRoot ? 1000 : Math.min(node.val ?? 1, 6))
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
      .onBackgroundClick(() => selectNode(null));

    const resize = () => {
      if (Graph) {
        Graph.width(container.offsetWidth || window.innerWidth);
        Graph.height(container.offsetHeight || window.innerHeight);
      }
    };
    window.addEventListener('resize', resize);
    setTimeout(resize, 100);

    // Disable OrbitControls dolly (has a hard stop at minDistance).
    // Replace with FPS-style forward movement so the user can zoom through any point.
    setTimeout(() => {
      const ctrl = typeof Graph.controls === 'function' ? Graph.controls() : null;
      if (ctrl) ctrl.enableZoom = false;
    }, 200);

    container.addEventListener('wheel', ev => {
      if (!Graph) return;
      ev.preventDefault();
      const cam  = Graph.camera();
      const ctrl = typeof Graph.controls === 'function' ? Graph.controls() : null;
      const fwd  = _camFwd(cam);
      const d    = -ev.deltaY * (ev.shiftKey ? 5 : 1.5);
      cam.position.x += fwd.x * d;
      cam.position.y += fwd.y * d;
      cam.position.z += fwd.z * d;
      if (ctrl?.target) {
        ctrl.target.x += fwd.x * d;
        ctrl.target.y += fwd.y * d;
        ctrl.target.z += fwd.z * d;
        ctrl.update();
      }
    }, { passive: false });

  } catch(e) {
    showError(t('error.renderFailed', e.message));
    console.error(e);
  }
}

// ── Node interaction ─────────────────────────────────────

function onNodeClick(node) {
  if (!node) return;
  selectNode(node);
}

function onNodeHover(node) {
  document.body.style.cursor = node ? 'pointer' : 'default';
  if (node && !selectedNode) showInfoPanel(node);
}

// ── Selection & subgraph highlight ──────────────────────

function selectNode(node) {
  if (!Graph) return;
  const gd = Graph.graphData();
  const newId = node?.id ?? null;

  // Toggle deselect on re-clicking the same node
  if (!node || newId === (selectedNode?.id ?? null)) {
    selectedNode = null;
    highlightNodeIds.clear();
    hideInfoPanel();
    applyHighlight();
    return;
  }

  selectedNode = node;
  highlightNodeIds.clear();
  highlightNodeIds.add(newId);

  // Echter Root-Knoten: ID aus currentData (stabil, kein Duplikat-Problem)
  const realRootId = currentData?.rootUnit ?? null;
  const isActualRoot = node.id === realRootId;

  if (isActualRoot) {
    // Root markiert alles
    gd.nodes.forEach(n => highlightNodeIds.add(n.id));
  } else {
    const fwd = new Map(gd.nodes.map(n => [n.id, []]));
    const rev = new Map(gd.nodes.map(n => [n.id, []]));
    gd.links.forEach(l => {
      const sId = typeof l.source === 'object' ? l.source.id : l.source;
      const tId = typeof l.target === 'object' ? l.target.id : l.target;
      fwd.get(sId)?.push(tId);
      rev.get(tId)?.push(sId);
    });

    // BFS vorwärts: alle Abhängigkeiten der ausgewählten Unit
    const fq = [newId];
    while (fq.length) {
      const id = fq.shift();
      for (const tid of (fwd.get(id) || [])) {
        if (!highlightNodeIds.has(tid)) { highlightNodeIds.add(tid); fq.push(tid); }
      }
    }

    // BFS rückwärts: EINEN Weg zur Startunit (echte Root-ID, kein Duplikat)
    if (realRootId && realRootId !== newId) {
      const prev = new Map([[newId, null]]);
      const bq = [newId];
      outer: while (bq.length) {
        const id = bq.shift();
        for (const sid of (rev.get(id) || [])) {
          if (!prev.has(sid)) {
            prev.set(sid, id);
            if (sid === realRootId) {
              let cur = sid;
              while (cur !== null) {
                highlightNodeIds.add(cur);
                cur = prev.get(cur) ?? null;
              }
              break outer;
            }
            bq.push(sid);
          }
        }
      }
    }
  }

  showInfoPanel(node);
  postToHost({ type: 'nodeClick', id: node._origId || node.id });
  applyHighlight();
}

// Find the first Mesh with a material inside a THREE.js object/group tree
function findMesh(obj) {
  if (!obj) return null;
  if (obj.isMesh && obj.material) return obj;
  for (const child of (obj.children || [])) {
    const m = findMesh(child);
    if (m) return m;
  }
  return null;
}

function applyHighlight() {
  if (!Graph) return;
  const gd = Graph.graphData();
  const active = selectedNode !== null;

  // Node colors: use Graph API (most reliable — bypasses internal material structure)
  const selId = active ? selectedNode.id : null;
  Graph.nodeColor(node => {
    if (!active) return node.color;
    const sel = node.id === selId;
    const lit = highlightNodeIds.has(node.id);
    return sel ? '#FFFFFF' : (lit ? node.color : '#1A2030');
  });

  // Resync positions in case nodeColor() rebuilt the THREE.js objects
  syncMeshes();

  const filterVisible = computeFilterVisible();
  const hasFilter = filterVisible !== null;

  // Node visibility + scale
  gd.nodes.forEach(n => {
    const obj = n.__threeObj;
    if (!obj) return;
    const origId = n._origId || n.id;
    obj.visible = !hasFilter || filterVisible.has(origId);
    obj.scale.setScalar(active && n.id === selId ? 1.5 : 1.0);
  });

  // Link visibility: filter AND highlight (node-ID-basiert, nicht objekt-referenz-basiert)
  gd.links.forEach(l => {
    const lo = l.__lineObj;
    if (!lo) return;
    const sNode = typeof l.source === 'object' ? l.source : _nodeById.get(l.source);
    const tNode = typeof l.target === 'object' ? l.target : _nodeById.get(l.target);
    const sOrig = sNode ? (sNode._origId || sNode.id) : null;
    const tOrig = tNode ? (tNode._origId || tNode.id) : null;
    const filterOk = !hasFilter || (sOrig && tOrig && filterVisible.has(sOrig) && filterVisible.has(tOrig));
    // Highlight-Check über stabile String-IDs statt Objekt-Referenzen
    const sId = sNode?.id ?? null;
    const tId = tNode?.id ?? null;
    const isHighlighted = active && sId && tId && highlightNodeIds.has(sId) && highlightNodeIds.has(tId);
    lo.visible = filterOk && (!active || isHighlighted);
    if (lo.material && lo.visible) {
      const mats = Array.isArray(lo.material) ? lo.material : [lo.material];
      mats.forEach(m => {
        m.color.set(isHighlighted
          ? (l.isCyclic ? '#FF5252' : '#64B5F6')
          : (l.isCyclic ? '#FF5252' : '#3A557F'));
        m.needsUpdate = true;
      });
    }
  });
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

// ── Graph visibility filter ──────────────────────────────

// Returns Set of origIds that are visible given current visFilter.
// Two-pass: base filters (formsOnly, sameDir) first, then usesFiltered.
function computeFilterVisible() {
  const hasBase = visFilter.formsOnly || visFilter.sameDir;
  if (!hasBase && !visFilter.usesFiltered) return null; // nothing active

  const rootNode = currentData?.nodes.find(n =>
    n.id.toLowerCase() === (currentData?.rootUnit || '').toLowerCase());
  const rootDir = (rootNode?.dir || '').toLowerCase().replace(/\\/g, '/');

  // Step 1: base filter
  const baseVisible = new Set();
  (currentData?.nodes || []).forEach(n => {
    if (visFilter.formsOnly && n.unitType !== 'Form') return;
    if (visFilter.sameDir) {
      const nodeDir = (n.dir || '').toLowerCase().replace(/\\/g, '/');
      if (!rootDir || !nodeDir.startsWith(rootDir)) return;
    }
    baseVisible.add(n.id);
  });

  if (!visFilter.usesFiltered) return baseVisible;

  // Step 2: keep only nodes (from base) that have at least one uses-link
  // pointing to another node that also passes base filter
  const links = currentData?.links || [];
  const result = new Set();
  baseVisible.forEach(id => {
    const hasFilteredUses = links.some(l => {
      const src = l.source?.id ?? l.source;
      const tgt = l.target?.id ?? l.target;
      return src.toLowerCase() === id.toLowerCase() && baseVisible.has(tgt);
    });
    if (hasFilteredUses) result.add(id);
  });
  return result;
}

window.setVisFilter = function(filter) {
  Object.assign(visFilter, filter);
  applyHighlight();
};

// ── loadGraph (called from C#) ───────────────────────────

window.loadGraph = function(data) {
  hideLoading();
  visFilter = { formsOnly: false, sameDir: false, usesFiltered: false };

  if (!Graph) {
    showError(t('error.libNotInit'));
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
      showError(t('error.renderFailed', e.message));
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

  const off = { x: span * 0.75, y: span * 0.55, z: span * 0.85 };
  Graph.cameraPosition(
    { x: cx + off.x, y: cy + off.y, z: cz + off.z },
    { x: cx, y: cy, z: cz }, 0);
}

// Shared helper: camera above root level, slightly in front, looking onto the filled area.
// rootAxis='y': tree mode (depth on Y, spread in XZ)
// rootAxis='z': force/3D mode (depth on Z, spread in XY)
function rootTopCamera(rootAxis) {
  const gd = Graph.graphData();
  if (!gd.nodes.length) return;
  const xs = gd.nodes.map(n => n.x ?? 0);
  const ys = gd.nodes.map(n => n.y ?? 0);
  const zs = gd.nodes.map(n => n.z ?? 0);

  if (rootAxis === 'y') {
    const cx = (Math.min(...xs) + Math.max(...xs)) / 2;
    const cz = (Math.min(...zs) + Math.max(...zs)) / 2;
    const maxY = Math.max(...ys);
    const spanY  = maxY - Math.min(...ys);
    const spanXZ = Math.max(Math.max(...xs) - Math.min(...xs), Math.max(...zs) - Math.min(...zs)) + 1;
    const dist   = Math.max(spanY, spanXZ);
    Graph.cameraPosition(
      { x: cx, y: maxY + dist * 0.25, z: cz + dist * 0.7 },
      { x: cx, y: maxY - spanY * 0.2, z: cz }, 0);
  } else {
    // 3D/force mode: root at (0,0,0), depth on negative Z, rings in XY
    const spanZ  = Math.max(...zs) - Math.min(...zs);
    const spanXY = Math.max(Math.max(...xs) - Math.min(...xs), Math.max(...ys) - Math.min(...ys)) + 1;
    const dist   = Math.max(spanZ, spanXY);
    const a      = 30 * Math.PI / 180;
    const vd     = dist * 0.8;

    // Set camera directly via THREE.js to avoid OrbitControls orientation glitches
    const cam  = Graph.camera();
    const ctrl = typeof Graph.controls === 'function' ? Graph.controls() : null;
    cam.up.set(0, 1, 0);
    cam.position.set(0, vd * Math.sin(a), vd * Math.cos(a));
    if (ctrl) {
      ctrl.target.set(0, 0, 0); // look at root
      ctrl.update();
    }
  }
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
window.setMaxNodes = function(n) {
  _maxNodes = Math.max(100, n);
  if (layoutMode === 'tree' && currentData) applyLayout('tree', currentData);
};

function expandToTree(nodes, links, rootId) {
  const MAX_NODES = _maxNodes;
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

  // BFS: level-by-level expansion so the cap cuts deepest levels, not first branches
  const queue = [{ origId: rootId, parentTreeId: null, ancestors: new Set() }];

  while (queue.length > 0 && treeNodes.length < MAX_NODES) {
    const { origId, parentTreeId, ancestors } = queue.shift();
    if (ancestors.has(origId)) continue;         // back-edge → cycle, skip
    const orig = origById.get(origId);
    if (!orig) continue;

    const treeId = parentTreeId === null ? origId : `${origId}~~${++uid}`;
    treeNodes.push({ ...orig, id: treeId, _origId: origId });

    if (parentTreeId !== null)
      treeLinks.push({ source: parentTreeId, target: treeId, color: '#3A557F', isCyclic: false, kind: 'interface' });

    const next = new Set(ancestors);
    next.add(origId);
    (fwd.get(origId) || []).forEach(childId =>
      queue.push({ origId: childId, parentTreeId: treeId, ancestors: next })
    );
  }

  return { nodes: treeNodes, links: treeLinks };
}

function applyLayout(mode, data) {
  data = data || currentData;
  if (!data) return;

  selectedNode = null;
  highlightNodeIds.clear();
  layoutMode = mode;

  showLoading('Berechne Layout…');

  // Sende saubere (Three.js-freie) Kopien an den Worker
  const workerNodes = data.nodes.map(n => ({
    id: n.id, name: n.name, color: n.color, val: n.val,
    unitType: n.unitType, isRoot: n.isRoot || false,
    filePath: n.filePath || '', dir: n.dir || ''
  }));
  const workerLinks = data.links.map(l => ({
    source: String(l.source?.id ?? l.source),
    target: String(l.target?.id ?? l.target),
    kind: l.kind || 'interface',
    isCyclic: l.isCyclic || false,
    color: l.color || '#3A557F'
  }));

  log(`applyLayout mode=${mode} nodes=${workerNodes.length} → Worker`);
  _layoutWorker.postMessage({
    mode, nodes: workerNodes, links: workerLinks,
    rootUnit: data.rootUnit, maxNodes: _maxNodes
  });
}

// Wird vom Worker-Callback aufgerufen, nachdem Positionen berechnet wurden
function _applyLayoutResult(mode, nodes, links) {
  hideLoading();
  log(`_applyLayoutResult mode=${mode} nodes=${nodes.length} links=${links.length}`);
  try {
    // Auto-Rotation zurücksetzen — Hauptachsen für neues Layout neu bestimmen
    _rotData = null;

    _nodeById = new Map(nodes.map(n => [n.id, n]));

    Graph.dagMode(null);
    Graph.d3Force('center', null);
    Graph.d3Force('charge', null);
    Graph.d3Force('link').strength(0);
    Graph.cooldownTicks(Infinity);
    Graph.cooldownTime(15000);

    Graph.graphData({ nodes, links });

    // Stats & overlays
    const stats = currentData?.stats || {};
    document.getElementById('st-units').textContent = stats.unitCount ?? nodes.length;
    document.getElementById('st-edges').textContent = stats.edgeCount ?? links.length;
    document.getElementById('st-cycles').textContent = stats.cycleCount ?? currentData?.cycles?.length ?? 0;
    document.getElementById('stats-overlay').classList.add('visible');
    document.getElementById('legend').classList.add('visible');
    document.getElementById('nav-panel').classList.add('visible');
    document.getElementById('rotate-panel').classList.add('visible');
    buildCyclePanel(currentData?.cycles || []);

    // Anzahl der Sync-Frames skaliert mit Knotenanzahl
    const syncFrames = nodes.length > 10000 ? 60 : nodes.length > 2000 ? 120 : 240;

    setTimeout(() => {
      try {
        syncMeshes();
        optimizeNodeGeometries(); // geteilte Low-Poly-Geometrie für alle Knoten
        let frames = 0;
        const tick = () => { syncMeshes(); if (++frames < syncFrames) requestAnimationFrame(tick); };
        requestAnimationFrame(tick);
        if (mode === 'tree')       rootTopCamera('y');
        else if (mode === 'force') rootTopCamera('z');
        else                       centerCameraOnGraph();
      } catch(e) {
        log(`Layout sync ERROR: ${e.message}`);
      }
    }, 1200);

  } catch(e) {
    log(`_applyLayoutResult ERROR: ${e.message}`);
    showError(t('error.layoutFailed', e.message));
  }
}

// Ersetzt alle Knoten-Sphere-Geometrien durch Low-Poly-Versionen (6×4 Segmente).
// Pro einzigartigem nodeVal wird exakt eine Geometrie erstellt und geteilt.
// Radius bleibt korrekt (baked-in wie im Original), aber Dreieckzahl sinkt ~80%.
function optimizeNodeGeometries() {
  const nodes = Graph.graphData().nodes;
  const first = nodes.find(n => n.__threeObj?.geometry?.type?.includes('Sphere'));
  if (!first) return;
  const SphereGeo = first.__threeObj.geometry.constructor;
  const NODE_RS = 8; // nodeRelSize — muss mit .nodeRelSize(8) übereinstimmen
  const geoByVal = new Map();
  const getGeo = val => {
    if (!geoByVal.has(val)) {
      const r = Math.cbrt(Math.max(0, val)) * NODE_RS;
      geoByVal.set(val, new SphereGeo(r, 6, 4));
    }
    return geoByVal.get(val);
  };
  let n = 0;
  nodes.forEach(node => {
    const mesh = node.__threeObj;
    if (!mesh?.geometry) return;
    // Root-Knoten: val=1000 → Radius = cbrt(1000)*8 = 10*8 = 80 (≈10× normaler Knoten)
    const val = node.isRoot ? 1000 : Math.min(node.val ?? 1, 6);
    const geo = getGeo(val);
    if (mesh.geometry === geo) return;
    mesh.geometry.dispose();
    mesh.geometry = geo;
    n++;
  });
  if (n > 0) log(`Geometry optimized: ${n} nodes, ${geoByVal.size} unique sizes (6×4 low-poly)`);
}

// ── Public API (called from C#) ──────────────────────────

window.highlightNode = function(nodeId) {
  if (!Graph) return;
  const nodes = Graph.graphData().nodes;

  // Match by origId to handle tree-mode duplicates (IDs like "unitName~~42")
  const matches = nodes.filter(n => (n._origId || n.id) === nodeId);
  if (!matches.length) return;

  // Pick the instance at the shallowest depth (highest level in the hierarchy)
  const best = matches.reduce((a, b) =>
    (a.__depth ?? Infinity) <= (b.__depth ?? Infinity) ? a : b);

  // Guard: skip if already selected — prevents 3D-click → sidebar-update → re-trigger loop
  if (selectedNode?.id === best.id) return;

  selectNode(best);
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

// ── Keyboard navigation (WASD + QE + RF) ─────────────────
//
//  W/S  — forward / backward  (camera look direction)
//  A/D  — strafe left / right
//  Q/E  — roll CCW / CW       (rotate around look axis)
//  R/F  — ascend / descend    (world Y axis)
//  Shift — 3× speed boost

const _navKeys = new Set(['w','s','a','d','q','e','r','f',
                          'arrowleft','arrowright','arrowup','arrowdown']);
const _keysDown = new Set();

function toggleHelp() {
  document.getElementById('help-modal').classList.toggle('visible');
}
window.showHelp = () => document.getElementById('help-modal').classList.add('visible');

window.setFullscreenMode = function(on) {
  ['info-panel', 'cycle-panel'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.style.display = on ? 'none' : '';
  });
};

document.addEventListener('keydown', ev => {
  if (ev.target.tagName === 'INPUT' || ev.target.tagName === 'TEXTAREA') return;
  if (ev.key === '?' || ev.key === 'F1') { toggleHelp(); ev.preventDefault(); return; }
  if (ev.key === 'F11') { postToHost({ type: 'toggleFullscreen' }); ev.preventDefault(); return; }
  if (ev.key === 'Escape') {
    const modal = document.getElementById('help-modal');
    if (modal.classList.contains('visible')) { modal.classList.remove('visible'); return; }
    postToHost({ type: 'exitFullscreen' }); // verlässt Vollbild (C# ignoriert, falls inaktiv)
    return;
  }
  const k = ev.key.toLowerCase();
  if (!_navKeys.has(k) && k !== 'shift') return;
  _keysDown.add(k);
  ev.preventDefault();
});
document.addEventListener('keyup', ev => _keysDown.delete(ev.key.toLowerCase()));

// Read camera local axes from its world matrix (no THREE.Vector3 import needed)
function _camFwd(cam) { const m = cam.matrixWorld.elements; return { x: -m[8], y: -m[9], z: -m[10] }; }
function _camRgt(cam) { const m = cam.matrixWorld.elements; return { x:  m[0], y:  m[1], z:   m[2] }; }

(function _navLoop() {
  requestAnimationFrame(_navLoop);
  if (!Graph || _keysDown.size === 0) return;

  const cam  = Graph.camera();
  const ctrl = typeof Graph.controls === 'function' ? Graph.controls() : null;
  const fast = _keysDown.has('shift');
  const spd  = fast ? 135 : 45;

  const fwd = _camFwd(cam);
  const rgt = _camRgt(cam);

  let dx = 0, dy = 0, dz = 0;
  if (_keysDown.has('w')) { dx += fwd.x*spd; dy += fwd.y*spd; dz += fwd.z*spd; }
  if (_keysDown.has('s')) { dx -= fwd.x*spd; dy -= fwd.y*spd; dz -= fwd.z*spd; }
  if (_keysDown.has('a')) { dx -= rgt.x*spd; dy -= rgt.y*spd; dz -= rgt.z*spd; }
  if (_keysDown.has('d')) { dx += rgt.x*spd; dy += rgt.y*spd; dz += rgt.z*spd; }
  // Ascend/descend along camera's local up axis (tracks roll)
  const up = cam.up;
  if (_keysDown.has('r')) { dx += up.x*spd; dy += up.y*spd; dz += up.z*spd; }
  if (_keysDown.has('f')) { dx -= up.x*spd; dy -= up.y*spd; dz -= up.z*spd; }

  cam.position.x += dx; cam.position.y += dy; cam.position.z += dz;
  if (ctrl?.target) {
    ctrl.target.x += dx; ctrl.target.y += dy; ctrl.target.z += dz;
    ctrl.update();
  }

  // Roll: rotate camera.up around the forward axis (Rodrigues' formula)
  const rollDelta = _keysDown.has('e') ? 0.015 : _keysDown.has('q') ? -0.015 : 0;
  if (rollDelta !== 0) {
    const f = _camFwd(cam);
    const u = cam.up;
    const c = Math.cos(rollDelta), s = Math.sin(rollDelta);
    const dot = f.x*u.x + f.y*u.y + f.z*u.z;
    cam.up.set(
      c*u.x + s*(f.y*u.z - f.z*u.y) + (1-c)*dot*f.x,
      c*u.y + s*(f.z*u.x - f.x*u.z) + (1-c)*dot*f.y,
      c*u.z + s*(f.x*u.y - f.y*u.x) + (1-c)*dot*f.z
    );
    if (ctrl) ctrl.update();
  }

  // Arrow keys: FPS look — rotate the look direction, camera stays fixed
  const TILT = 0.0054; // 30 % des ursprünglichen Tempos
  const tiltH = _keysDown.has('arrowleft') ?  TILT : _keysDown.has('arrowright') ? -TILT : 0;
  const tiltV = _keysDown.has('arrowup')   ?  TILT : _keysDown.has('arrowdown')  ? -TILT : 0;
  if ((tiltH !== 0 || tiltV !== 0) && ctrl?.target) {
    // Look vector: camera → target (FPS: we rotate this, camera stays fixed)
    let ox = ctrl.target.x - cam.position.x;
    let oy = ctrl.target.y - cam.position.y;
    let oz = ctrl.target.z - cam.position.z;

    const rotAround = (ox, oy, oz, ax, ay, az, a) => {
      const c = Math.cos(a), s = Math.sin(a), d = ax*ox + ay*oy + az*oz;
      return [
        c*ox + s*(ay*oz - az*oy) + (1-c)*d*ax,
        c*oy + s*(az*ox - ax*oz) + (1-c)*d*ay,
        c*oz + s*(ax*oy - ay*ox) + (1-c)*d*az,
      ];
    };

    if (tiltH !== 0) {                      // yaw: around camera up
      const u = cam.up;
      [ox, oy, oz] = rotAround(ox, oy, oz, u.x, u.y, u.z, tiltH);
    }
    if (tiltV !== 0) {                      // pitch: around camera right
      const r = _camRgt(cam);
      [ox, oy, oz] = rotAround(ox, oy, oz, r.x, r.y, r.z, tiltV);
    }

    // Move target, keep camera fixed
    ctrl.target.set(cam.position.x + ox, cam.position.y + oy, cam.position.z + oz);
    ctrl.update();
  }
})();

// ── Navigation Panel ─────────────────────────────────────

(function _initNavPanel() {
  document.querySelectorAll('#nav-panel [data-key]').forEach(btn => {
    const key = btn.dataset.key;
    const press   = () => { _keysDown.add(key);    btn.classList.add('pressed'); };
    const release = () => { _keysDown.delete(key); btn.classList.remove('pressed'); };
    btn.addEventListener('mousedown',  press);
    btn.addEventListener('mouseup',    release);
    btn.addEventListener('mouseleave', release);
    btn.addEventListener('touchstart', e => { e.preventDefault(); press(); },   { passive: false });
    btn.addEventListener('touchend',   e => { e.preventDefault(); release(); }, { passive: false });
  });
})();

// ── Auto-Rotation (Drehen-Panel) ─────────────────────────
// Kamerabasiert: das Objekt dreht sich um die X- und Z-Achse der Kamera.
// Die Kamera bleibt fix; wir rotieren die gemeinsame THREE.Group der Knoten
// um deren Schwerpunkt.
let _autoRotate = false;
let _rotData = null;  // { center, basePos }

function _graphGroup() {
  const n0 = Graph?.graphData()?.nodes?.[0]?.__threeObj;
  return n0?.parent || null;
}

function _computeRotData(group) {
  const nodes = Graph.graphData().nodes;
  const n = nodes.length || 1;
  let mx = 0, my = 0, mz = 0;
  nodes.forEach(p => { mx += p.x || 0; my += p.y || 0; mz += p.z || 0; });
  return {
    center:  { x: mx / n, y: my / n, z: mz / n },
    basePos: group.position.clone(),
  };
}

(function _autoRotateLoop() {
  requestAnimationFrame(_autoRotateLoop);
  if (!Graph || !_autoRotate) return;
  const group = _graphGroup();
  if (!group) return;
  if (!_rotData) _rotData = _computeRotData(group);

  const SPEED = 0.0006; // 10 % des ursprünglichen Tempos
  const cam = Graph.camera();

  // Turntable: Drehung um die vertikale Kamera-Achse (cam.up), damit das
  // Objekt seine Seiten zeigt — nicht um die Blickachse (Uhr) und nicht
  // um die Querachse (Kippen).
  const up = cam.up;
  const q  = group.quaternion.clone();
  const ax = cam.position.clone(); ax.set(up.x, up.y, up.z);
  q.setFromAxisAngle(ax, SPEED);
  group.quaternion.premultiply(q);

  // Position so setzen, dass das Zentrum (Schwerpunkt) fix bleibt:
  //   groupPos = O + C − R·C
  const C = _rotData.center, O = _rotData.basePos;
  const rc = cam.position.clone();
  rc.set(C.x, C.y, C.z);
  rc.applyQuaternion(group.quaternion);
  group.position.set(O.x + C.x - rc.x, O.y + C.y - rc.y, O.z + C.z - rc.z);
})();

(function _initRotatePanel() {
  const cb = document.getElementById('cb-rot');
  cb?.addEventListener('change', e => _autoRotate = e.target.checked);
})();

// ── Bootstrap ────────────────────────────────────────────

initGraph();
postToHost({ type: 'ready' });
