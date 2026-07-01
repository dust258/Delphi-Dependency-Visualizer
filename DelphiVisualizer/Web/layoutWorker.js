// layoutWorker.js — Layout-Berechnung im Worker-Thread
// Kein DOM, kein Three.js — nur reine Datenmanipulation

const NODE_REL_SIZE = 4;
function sphereRadius(val) {
  return Math.cbrt(Math.min(val ?? 1, 6)) * NODE_REL_SIZE;
}

function computeDepths(nodes, links, rootId) {
  const fwd = new Map();
  nodes.forEach(n => fwd.set(n.id, []));
  links.forEach(l => {
    const s = typeof l.source === 'object' ? l.source.id : l.source;
    const t = typeof l.target === 'object' ? l.target.id : l.target;
    if (fwd.has(s)) fwd.get(s).push(t);
  });
  const depth = new Map(), byDepth = [];
  depth.set(rootId, 0);
  const q = [rootId];
  while (q.length) {
    const id = q.shift(), d = depth.get(id);
    while (byDepth.length <= d) byDepth.push([]);
    byDepth[d].push(id);
    (fwd.get(id) || []).forEach(t => { if (!depth.has(t)) { depth.set(t, d + 1); q.push(t); } });
  }
  return { depth, byDepth };
}

function seedLayeredPositions(nodes, links, rootId) {
  const nb = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);
  const HS = 40, RS = 50, LS = 120;
  let baseY = 0;
  byDepth.forEach((ids, d) => {
    if (!ids.length) return;
    const MPR = Math.ceil(Math.sqrt(ids.length * 2.5));
    const rows = Math.ceil(ids.length / MPR);
    ids.forEach((id, i) => {
      const n = nb.get(id); if (!n) return;
      const row = Math.floor(i / MPR), col = i % MPR;
      const nir = row === rows - 1 ? ids.length - row * MPR : MPR;
      n.x = -((nir - 1) * HS) / 2 + col * HS;
      n.y = baseY - row * RS; n.z = 0; n.__depth = d;
      n.fx = n.x; n.fy = n.y; n.fz = 0;
    });
    baseY -= (rows - 1) * RS + LS;
  });
  const botY = baseY - LS;
  nodes.filter(n => !depth.has(n.id)).forEach((n, i) => {
    n.x = (i % 20 - 10) * HS; n.y = botY - Math.floor(i / 20) * RS; n.z = 0;
    n.__depth = byDepth.length; n.fx = n.x; n.fy = n.y; n.fz = 0;
  });
}

function seedTreePositions(nodes, links, rootId) {
  const nb = new Map(nodes.map(n => [n.id, n]));
  const ch = new Map(nodes.map(n => [n.id, []]));
  links.forEach(l => {
    const s = typeof l.source === 'object' ? l.source.id : l.source;
    const t = typeof l.target === 'object' ? l.target.id : l.target;
    if (ch.has(s)) ch.get(s).push(t);
  });
  const sz = new Map();
  const computeSize = id => {
    const c = ch.get(id) || [];
    const s = !c.length ? 1 : c.reduce((a, x) => a + computeSize(x), 0);
    sz.set(id, s); return s;
  };
  computeSize(rootId);
  const dOf = new Map([[rootId, 0]]);
  const bq = [rootId];
  while (bq.length) {
    const id = bq.shift();
    (ch.get(id) || []).forEach(c => { if (!dOf.has(c)) { dOf.set(c, dOf.get(id) + 1); bq.push(c); } });
  }
  const npd = new Map();
  nodes.forEach(n => { const d = dOf.get(n.id) ?? 0; npd.set(d, (npd.get(d) || 0) + 1); });
  const MIN_ARC = 20, BASE_R = 400, MAX_R = 9000, LS = 450;
  const radAt = d => Math.min(MAX_R, Math.max(BASE_R * d, ((npd.get(d) || 1) * MIN_ARC) / (2 * Math.PI)));
  const sp = (id, x, y, z, d) => {
    const n = nb.get(id); if (!n) return;
    n.x = x; n.y = y; n.z = z; n.__depth = d; n.fx = x; n.fy = y; n.fz = z;
  };
  sp(rootId, 0, 0, 0, 0);
  const q = [{ id: rootId, depth: 0, aFrom: 0, aTo: 2 * Math.PI }];
  while (q.length) {
    const { id: pid, depth, aFrom, aTo } = q.shift();
    const children = ch.get(pid) || []; if (!children.length) continue;
    const tot = children.reduce((a, c) => a + (sz.get(c) || 1), 0);
    const y = -(depth + 1) * LS, r = radAt(depth + 1);
    let aS = aFrom;
    children.forEach(cid => {
      const s = sz.get(cid) || 1, aSlice = (s / tot) * (aTo - aFrom), aMid = aS + aSlice / 2;
      sp(cid, r * Math.cos(aMid), y, r * Math.sin(aMid), depth + 1);
      q.push({ id: cid, depth: depth + 1, aFrom: aS, aTo: aS + aSlice });
      aS += aSlice;
    });
  }
}

function seedRadialPositions(nodes, links, rootId) {
  const nb = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);
  const GAP = 28, rr = [0];
  byDepth.forEach((ids, d) => {
    if (d === 0) {
      const r = nb.get(ids[0]);
      if (r) { r.x = 0; r.y = 0; r.z = 0; r.__depth = 0; r.fx = 0; r.fy = 0; r.fz = 0; }
      return;
    }
    const msr = Math.max(...ids.map(id => sphereRadius(nb.get(id)?.val)));
    const arc = msr * 2 + GAP, prevR = rr[d - 1] ?? 0;
    const minR = prevR + msr * 2 + 60;
    const arcR = ids.length <= 1 ? minR : Math.max(minR, (ids.length * arc) / (2 * Math.PI));
    rr[d] = arcR;
    ids.forEach((id, i) => {
      const n = nb.get(id); if (!n) return;
      const a = (2 * Math.PI * i) / ids.length;
      n.x = arcR * Math.cos(a); n.y = arcR * Math.sin(a); n.z = 0;
      n.__depth = d; n.fx = n.x; n.fy = n.y; n.fz = 0;
    });
  });
  const outerR = (rr[rr.length - 1] ?? 0) + 150;
  nodes.filter(n => !depth.has(n.id)).forEach(n => {
    const a = Math.random() * Math.PI * 2;
    n.x = outerR * Math.cos(a); n.y = outerR * Math.sin(a); n.z = 0;
    n.fx = n.x; n.fy = n.y; n.fz = n.z;
  });
}

function seed3DPositions(nodes, links, rootId) {
  const nb = new Map(nodes.map(n => [n.id, n]));
  const { depth, byDepth } = computeDepths(nodes, links, rootId);
  const ZS = 220, GAP = 30;
  byDepth.forEach((ids, d) => {
    if (!ids.length) return;
    const maxR = Math.max(...ids.map(id => sphereRadius(nb.get(id)?.val)));
    const step = maxR * 2 + GAP;
    const radius = ids.length === 1 ? 0 : Math.max(step, (ids.length * step) / (2 * Math.PI));
    ids.forEach((id, i) => {
      const n = nb.get(id); if (!n) return;
      const a = ids.length === 1 ? 0 : (2 * Math.PI * i) / ids.length;
      n.x = radius * Math.cos(a); n.y = radius * Math.sin(a);
      n.z = -d * ZS; n.__depth = d; n.fx = n.x; n.fy = n.y; n.fz = n.z;
    });
  });
  const maxD = byDepth.length;
  nodes.filter(n => !depth.has(n.id)).forEach((n, i) => {
    const a = (2 * Math.PI * i) / 20;
    n.x = 300 * Math.cos(a); n.y = 300 * Math.sin(a); n.z = -maxD * ZS;
    n.fx = n.x; n.fy = n.y; n.fz = n.z;
  });
}

// Iterativer DFS — O(n) Zeit und Speicher, kein Recursion-Overflow
function expandToTree(nodes, links, rootId, maxNodes) {
  const origById = new Map(nodes.map(n => [n.id, n]));
  const fwd = new Map(nodes.map(n => [n.id, []]));
  links.forEach(l => {
    const s = typeof l.source === 'object' ? l.source.id : l.source;
    const t = typeof l.target === 'object' ? l.target.id : l.target;
    if (fwd.has(s)) fwd.get(s).push(t);
  });

  const treeNodes = [], treeLinks = [];
  let uid = 0;
  const ancestors = new Set();
  // Stack: { origId, parentTreeId, childIdx, treeId }
  const stack = [{ origId: rootId, parentTreeId: null, childIdx: 0, treeId: null }];

  while (stack.length && treeNodes.length < maxNodes) {
    const frame = stack[stack.length - 1];

    if (frame.childIdx === 0) {
      if (ancestors.has(frame.origId)) { stack.pop(); continue; }
      const orig = origById.get(frame.origId);
      if (!orig) { stack.pop(); continue; }
      const treeId = frame.parentTreeId === null ? frame.origId : `${frame.origId}~~${++uid}`;
      frame.treeId = treeId;
      treeNodes.push({ ...orig, id: treeId, _origId: frame.origId });
      if (frame.parentTreeId !== null)
        treeLinks.push({ source: frame.parentTreeId, target: treeId, color: '#3A557F', isCyclic: false, kind: 'interface' });
      ancestors.add(frame.origId);
    }

    const children = fwd.get(frame.origId) || [];
    if (frame.childIdx < children.length && treeNodes.length < maxNodes) {
      const childId = children[frame.childIdx++];
      stack.push({ origId: childId, parentTreeId: frame.treeId, childIdx: 0, treeId: null });
    } else {
      ancestors.delete(frame.origId);
      stack.pop();
    }
  }

  return { nodes: treeNodes, links: treeLinks };
}

self.onmessage = function(e) {
  const { mode, nodes, links, rootUnit, maxNodes } = e.data;
  try {
    let outNodes = nodes, outLinks = links;
    if (mode === 'tree') {
      const ex = expandToTree(nodes, links, rootUnit, maxNodes);
      outNodes = ex.nodes; outLinks = ex.links;
      seedTreePositions(outNodes, outLinks, rootUnit);
    } else if (mode === 'force') {
      seed3DPositions(outNodes, outLinks, rootUnit);
    } else if (mode === 'radial') {
      seedRadialPositions(outNodes, outLinks, rootUnit);
    } else {
      seedLayeredPositions(outNodes, outLinks, rootUnit);
    }
    self.postMessage({ mode, nodes: outNodes, links: outLinks });
  } catch(err) {
    self.postMessage({ error: err.message + '\n' + err.stack });
  }
};
