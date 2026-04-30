# sqlfmt

A SQL formatter supporting multiple dialects. Formats SQL through a parse → IR → render pipeline with a strict round-trip correctness check.

## Usage

```sh
# Format a statement directly
cargo run -- --dialect postgres --stmt "SELECT a, b FROM t WHERE x = 1"

# Format from stdin
echo "SELECT a, b FROM t" | cargo run -- --dialect materialize

# Options
cargo run -- --help
```

Supported dialects: `postgres`, `materialize`. `cockroachdb` and `googlesql` are stubs (not yet implemented).

## Architecture

**Parse → IR → Render**

1. A `Dialect` implementation parses SQL into `sqlfmt-ir::Node` (the intermediate representation).
2. `sqlfmt-render` renders `Node` to a formatted string using the `pretty` crate (Wadler-Lindig algorithm).
3. `sqlfmt-core::format_sql` orchestrates this and performs a **round-trip AST equality check** after rendering to catch any nodes dropped during conversion.

### Crates

| Crate | Purpose |
|-------|---------|
| `sqlfmt-ir` | `Node` enum — the IR shared by all dialects |
| `sqlfmt-core` | `Dialect` trait and `format_sql` orchestration |
| `sqlfmt-render` | Converts `Node` to `pretty::RcDoc` and renders |
| `dialect-postgres` | PostgreSQL: calls `libpg_query` (C FFI) → JSON → IR |
| `dialect-postgres-convert` | Converts `pg_query` JSON AST to IR |
| `dialect-materialize` | Materialize: uses `mz_sql_parser` → IR. Covers SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, SET, GRANT, REVOKE, COMMENT |
| `dialect-cockroachdb` | Stub (not yet implemented) |
| `dialect-googlesql` | Stub (not yet implemented) |
| `web` | WASM build for browser use |

### Round-trip correctness

The formatter is strict: after rendering, it re-parses the output and compares ASTs. If the ASTs differ, `format_sql` returns `SqlfmtError::Roundtrip`. This ensures dialect converters produce a lossless IR — no SQL nodes can be silently dropped during conversion.

### `Node::Unformatted` — tracking conversion progress

Converters use `Node::Unformatted` (not `Node::Text`) for AST nodes that haven't been converted to structured IR yet. The corpus tests enable `error_on_unformatted`, which causes formatting to fail when encountering unconverted nodes. This drives the improvement workflow:

- **`Node::Text`** — intentional structural text (whitespace, punctuation, case-preserved names)
- **`Node::Unformatted`** — unconverted AST nodes (catch-all fallbacks, complex edge cases)

Search a converter for `Node::Unformatted` to see all unconverted code paths — each represents a class of statements that need structured IR.

## Building

```sh
cargo build

# WASM web app (requires wasm-pack)
./dev.sh
./dev.sh --serve --port=8012
```

## Testing

### Unit tests

```sh
# All crates
cargo test

# Specific crate
cargo test -p dialect-postgres

# Single test
cargo test -p dialect-postgres test_format_roundtrip
```

### Corpus round-trip testing

Each dialect crate has its own corpus tests in `tests/corpus.rs` that test the formatter against large real-world SQL corpora downloaded from upstream projects. The tests use `sqlfmt-corpus-tests` as a dev-dependency for shared infrastructure.

**Three test tiers:**

| Test | Command | What it does |
|------|---------|--------------|
| `test_external_corpus` | `cargo test -p dialect-materialize -- --ignored` | Fetches live SQL from upstream, classifies statements into `failing/` (Unformatted/Roundtrip errors) and `success/` (clean formatting) |
| `test_rewrite_corpus` | `cargo test -p dialect-materialize test_rewrite_corpus -- --ignored` | Scans `failing/`, moves now-passing statements to `success/` |
| `test_permanent_corpus` | `cargo test -p dialect-materialize` (runs automatically) | Verifies `success/` stays passing and `failing/` still fails |

**How it works:**

1. SQL test files are fetched from GitHub and cached locally. Delete the cache to force a re-download.
2. Each SQL statement is extracted and run through `format_sql`.
3. Statements that format successfully go to `testdata/success/{source}.sql`.
4. Statements that fail with `Roundtrip` or `Unformatted` errors go to `testdata/failing/{source}.sql`.
5. When you add structured IR for a node that was using `Node::Unformatted`, `test_rewrite_corpus` automatically moves those statements from `failing/` to `success/`.

**Corpora:**

| Dialect | Source repo | Format |
|---------|-------------|--------|
| Materialize | `MaterializeInc/materialize` — `test/sqllogictest/*.slt` | sqllogictest |
| PostgreSQL | `postgres/postgres` — `src/test/regress/sql/*.sql` | raw SQL |
| CockroachDB | `cockroachdb/cockroach` — `pkg/sql/logictest/testdata/logic_test/*` | sqllogictest |

**Testdata directory structure:**

```
crates/dialect-<name>/testdata/
  failing/
    <source>.sql    — known failures (Unformatted or Roundtrip errors)
  success/
    <source>.sql    — verified passing statements (regression suite)
```

### Adding a new dialect

Implement `sqlfmt_core::Dialect` (two methods: `parse` and `ast_equal`), convert the dialect's AST to `sqlfmt_ir::Node`, and register it in `src/main.rs`.
