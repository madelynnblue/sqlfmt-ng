// Web Worker for pg-query-emscripten parsing.
// Isolates the Emscripten WASM module from the main thread so that memory
// exhaustion crashes (from the known pg_query_free_parse_result leak in
// pg-query-emscripten@5.1.0) don't hang the page.

let pgQuery = null;
let parseCount = 0;
let initPromise = null;
const MAX_PARSES = 100; // Reinitialize before memory exhaustion.

// Returns a fresh or existing pgQuery, serializing concurrent initialization
// so that multiple incoming messages don't create duplicate WASM modules.
async function getPgQuery() {
  if (pgQuery && parseCount < MAX_PARSES) return pgQuery;
  if (!initPromise) {
    initPromise = (async () => {
      const { default: PgQueryModule } = await import('https://esm.sh/pg-query-emscripten@5.1.0');
      pgQuery = await PgQueryModule();
      parseCount = 0;
      initPromise = null;
    })();
  }
  await initPromise;
  return pgQuery;
}

async function doParse(sql) {
  const q = await getPgQuery();
  const result = q.parse(sql);
  parseCount++;
  const treeJson = typeof result.parse_tree === 'string'
    ? result.parse_tree
    : JSON.stringify(result.parse_tree);
  return { treeJson, error: result.error?.message || null };
}

onmessage = async (e) => {
  const { id, sql } = e.data;
  try {
    const parsed = await doParse(sql);
    postMessage({ id, ok: true, ...parsed });
  } catch {
    // Emscripten crash (exit(1) or function-table TypeError) —
    // reset and retry once with a fresh module.
    pgQuery = null;
    parseCount = 0;
    try {
      const parsed = await doParse(sql);
      postMessage({ id, ok: true, ...parsed });
    } catch (err2) {
      postMessage({ id, ok: false, error: err2?.message || String(err2) });
    }
  }
};
