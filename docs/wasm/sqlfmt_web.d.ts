/* tslint:disable */
/* eslint-disable */

/**
 * Check that formatting produced a semantically equivalent AST.
 * Only needed after text changes; option re-renders skip this.
 */
export function check_roundtrip(original: string, rendered: string, dialect: string): void;

/**
 * Format SQL using a native dialect parser.
 * dialect: "materialize".
 */
export function fmt(sql: string, dialect: string, width: number, tab_width: number, use_tabs: boolean, _case: string): string;

/**
 * Render pre-parsed SQL from a sqlfmt IR JSON string.
 * For dialects whose JS parsers produce sqlfmt IR directly rather than pg_query protobuf.
 */
export function fmt_from_ir(ir_json: string, dialect: string, width: number, tab_width: number, use_tabs: boolean, _case: string): string;

/**
 * Format a Postgres query from a pg-query-emscripten JSON parse tree.
 * Pass `JSON.stringify(result.parse_tree)` from `pg-query-emscripten`'s `parse()`.
 */
export function fmt_postgres_json(parse_tree_json: string, width: number, tab_width: number, use_tabs: boolean, _case: string): string;

/**
 * Parse SQL/JSON into a sqlfmt IR node and return it as a JSON string.
 * Used for validating input and caching the parse result so that option
 * changes (width, tabs, case) can re-render without re-parsing.
 */
export function parse_to_ir(sql: string, dialect: string): string;

/**
 * Compare two pg-query JSON parse trees for AST equality, ignoring location fields.
 * Pass `JSON.stringify(result.parse_tree)` for both arguments.
 * Returns true if the ASTs are structurally identical (modulo byte offsets).
 */
export function pg_json_ast_equal(json1: string, json2: string): boolean;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
    readonly memory: WebAssembly.Memory;
    readonly check_roundtrip: (a: number, b: number, c: number, d: number, e: number, f: number) => [number, number];
    readonly fmt: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => [number, number, number, number];
    readonly fmt_from_ir: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => [number, number, number, number];
    readonly fmt_postgres_json: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => [number, number, number, number];
    readonly parse_to_ir: (a: number, b: number, c: number, d: number) => [number, number, number, number];
    readonly pg_json_ast_equal: (a: number, b: number, c: number, d: number) => number;
    readonly __wbindgen_externrefs: WebAssembly.Table;
    readonly __wbindgen_malloc: (a: number, b: number) => number;
    readonly __wbindgen_realloc: (a: number, b: number, c: number, d: number) => number;
    readonly __externref_table_dealloc: (a: number) => void;
    readonly __wbindgen_free: (a: number, b: number, c: number) => void;
    readonly __wbindgen_start: () => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;

/**
 * Instantiates the given `module`, which can either be bytes or
 * a precompiled `WebAssembly.Module`.
 *
 * @param {{ module: SyncInitInput }} module - Passing `SyncInitInput` directly is deprecated.
 *
 * @returns {InitOutput}
 */
export function initSync(module: { module: SyncInitInput } | SyncInitInput): InitOutput;

/**
 * If `module_or_path` is {RequestInfo} or {URL}, makes a request and
 * for everything else, calls `WebAssembly.instantiate` directly.
 *
 * @param {{ module_or_path: InitInput | Promise<InitInput> }} module_or_path - Passing `InitInput` directly is deprecated.
 *
 * @returns {Promise<InitOutput>}
 */
export default function __wbg_init (module_or_path?: { module_or_path: InitInput | Promise<InitInput> } | InitInput | Promise<InitInput>): Promise<InitOutput>;
