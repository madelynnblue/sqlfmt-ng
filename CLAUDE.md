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

- **`sqlfmt-ir`** — the `Node` enum (the IR). `Node` has "sugar" variants (`Clauses`, `List`, `Wrap`, `Infix`, `Keyword`, `Identifier`) that carry semantic meaning, and "primitive" variants (`Text`, `Concat`, `Group`, `Nest`, `Line`, `Hardline`) that map directly to `pretty` combinators.
- **`sqlfmt-core`** — defines the `Dialect` trait (`parse` + `ast_equal`) and `format_sql`. No dialect-specific logic lives here.
- **`sqlfmt-render`** — converts `Node` to a `pretty::RcDoc` and renders it. Handles `RenderOpts` (line width, tab width, case transformation).
- **`dialect-postgres`** — calls `libpg_query` (C FFI via the `pg_query` crate) to parse SQL into JSON, then delegates to `dialect-postgres-convert`.
- **`dialect-postgres-convert`** — converts the `pg_query` JSON AST into `sqlfmt-ir::Node`. Also provides `json_ast_equal` for the round-trip check by comparing normalized JSON ASTs.
- **`dialect-materialize`** — uses `mz_sql_parser` to parse SQL; `convert.rs` walks the Materialize AST and converts it to `Node`. Currently only `SELECT` statements are fully converted; other statement types fall back to `Node::Text`.
- **`dialect-cockroachdb`**, **`dialect-googlesql`** — stubs, not yet implemented.
- **`web`** — `cdylib` crate compiled to WASM via `wasm-bindgen`; exposes formatting to the browser. The built output goes to `docs/wasm/` and is served from `docs/`.

### Adding a new dialect

Implement `sqlfmt_core::Dialect` (two methods: `parse` and `ast_equal`), convert the dialect's AST to `sqlfmt_ir::Node`, and add the dialect to `src/main.rs`.

### Key design note

The round-trip check in `format_sql` is strict: if the rendered SQL's AST differs from the input's AST, formatting fails with `SqlfmtError::Roundtrip`. This means dialect converters must produce a lossless IR representation.
