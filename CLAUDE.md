# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
# Build
cargo build

# Run tests (all crates)
cargo test

# Run tests for a specific crate
cargo test -p sqlfmt-core
cargo test -p dialect-postgres

# Run a single test by name
cargo test -p dialect-postgres test_format_roundtrip

# Run the CLI
cargo run -- --dialect postgres --stmt "SELECT 1"
echo "SELECT a, b FROM t" | cargo run -- --dialect materialize

# Build the WASM web app (requires wasm-pack)
./dev.sh
# Build and serve locally
./dev.sh --serve --port=8012
```

## Architecture

This is a Rust workspace SQL formatter with the following pipeline:

**Parse → IR → Render**

1. A `Dialect` implementation parses SQL into `sqlfmt-ir::Node` (the intermediate representation).
2. `sqlfmt-render` renders `Node` to a formatted string using the `pretty` crate (Wadler-Lindig algorithm).
3. `sqlfmt-core::format_sql` orchestrates this and performs a **round-trip AST equality check** after rendering to catch any nodes dropped during conversion.

### Crates

- **`sqlfmt-ir`** — the `Node` enum (the IR). `Node` has "sugar" variants (`Clauses`, `List`, `Wrap`, `Infix`, `Keyword`, `Identifier`) that carry semantic meaning, and "primitive" variants (`Text`, `Concat`, `Group`, `Nest`, `Line`, `Hardline`) that map directly to `pretty` combinators. Also includes `Unformatted` — a marker variant for unconverted AST nodes that causes `error_on_unformatted` to fail formatting (used by corpus tests to track which statements still need structured IR).
- **`sqlfmt-core`** — defines the `Dialect` trait (`parse` + `ast_equal`) and `format_sql`. No dialect-specific logic lives here.
- **`sqlfmt-render`** — converts `Node` to a `pretty::RcDoc` and renders it. Handles `RenderOpts` (line width, tab width, case transformation).
- **`dialect-postgres`** — calls `libpg_query` (C FFI via the `pg_query` crate) to parse SQL into JSON, then delegates to `dialect-postgres-convert`.
- **`dialect-postgres-convert`** — converts the `pg_query` JSON AST into `sqlfmt-ir::Node`. Also provides `json_ast_equal` for the round-trip check by comparing normalized JSON ASTs.
- **`dialect-materialize`** — uses `mz_sql_parser` to parse SQL; `convert.rs` walks the Materialize AST and converts it to `Node`. Covers SELECT, INSERT, UPDATE, DELETE, CREATE TABLE/MATERIALIZED VIEW/VIEW/INDEX, DROP, SET/RESET, GRANT/REVOKE, and COMMENT. Unconverted statement types and complex edge cases fall back to `Node::Unformatted`.
- **`dialect-cockroachdb`**, **`dialect-googlesql`** — stubs, not yet implemented.
- **`web`** — `cdylib` crate compiled to WASM via `wasm-bindgen`; exposes formatting to the browser. The built output goes to `docs/wasm/` and is served from `docs/`.

### Adding a new dialect

Implement `sqlfmt_core::Dialect` (two methods: `parse` and `ast_equal`), convert the dialect's AST to `sqlfmt_ir::Node`, and add the dialect to `src/main.rs`.

### Key design note

The round-trip check in `format_sql` is strict: if the rendered SQL's AST differs from the input's AST, formatting fails with `SqlfmtError::Roundtrip`. This means dialect converters must produce a lossless IR representation.

### `Node::Unformatted` vs `Node::Text` convention

Dialect converters MUST use `Node::Unformatted` (not `Node::Text`) for any AST node that isn't yet converted to structured IR:

- **`Node::Text`** — for intentional structural text: whitespace (`" "`), punctuation (`"."`, `":"`), wildcards (`"*"`), inline SQL fragments (`" IGNORE NULLS"`), case-preserved names
- **`Node::Unformatted`** — for unconverted AST nodes: catch-all match arms (`_ =>`), fallback paths for complex/unsupported variants, parser Display passthroughs (`format!("{node}")`)

The corpus tests set `error_on_unformatted: true`, so `Node::Unformatted` nodes cause formatting to fail with `SqlfmtError::Unformatted`. This drives the corpus workflow:

1. `test_external_corpus` — fetches upstream SQL, puts `Unformatted`/`Roundtrip` failures in `failing/`, successes in `success/`
2. When you convert a node from `Unformatted` to structured IR, `test_rewrite_corpus` moves those statements from `failing/` to `success/`
3. `test_permanent_corpus` ensures `success/` stays passing and `failing/` still fails

Search a converter for `Node::Unformatted` to find all unconverted code paths — each one represents work to do.
