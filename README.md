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

Supported dialects: `postgres`, `materialize`.

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
| `dialect-materialize` | Materialize: uses `mz_sql_parser` → IR |
| `dialect-cockroachdb` | Stub (not yet implemented) |
| `dialect-googlesql` | Stub (not yet implemented) |
| `web` | WASM build for browser use |

### Round-trip correctness

The formatter is strict: after rendering, it re-parses the output and compares ASTs. If the ASTs differ, `format_sql` returns `SqlfmtError::Roundtrip`. This ensures dialect converters produce a lossless IR — no SQL nodes can be silently dropped during conversion.

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

The `sqlfmt-corpus-tests` crate tests the formatter against large real-world SQL corpora downloaded from upstream projects. This finds statements that expose gaps in the IR conversion (cases where nodes are dropped or mishandled).

**How it works:**

1. SQL test files are fetched from GitHub at test time and cached locally in `target/sqlfmt-corpus-cache/`. Delete that directory to force a re-download.
2. Each SQL statement is extracted from the test files and run through `format_sql` for every dialect.
3. Parse errors are skipped — foreign-dialect SQL is expected to fail parsing.
4. Round-trip failures (AST changed after formatting) are written to `testdata/` files committed in this repo, named `{corpus}-{dialect}.sql`.
5. The test panics if any **new** failures are found (i.e., statements not already recorded in `testdata/`).

**Corpora:**

| Source | Repo | Format |
|--------|------|--------|
| Materialize | `MaterializeInc/materialize` — `test/sqllogictest/*.slt` | sqllogictest |
| PostgreSQL | `postgres/postgres` — `src/test/regress/sql/*.sql` | raw SQL |
| CockroachDB | `cockroachdb/cockroach` — `pkg/sql/logictest/testdata/logic_test/*` | sqllogictest |

**Running the corpus test:**

```sh
# Requires network access. Downloads corpora, runs round-trip tests.
cargo test -p sqlfmt-corpus-tests -- --ignored

# Set GITHUB_TOKEN to avoid rate limiting (60 req/hr unauthenticated vs 5000 authenticated)
GITHUB_TOKEN=ghp_... cargo test -p sqlfmt-corpus-tests -- --ignored
```

**Permanent regression corpus:**

Once round-trip failures are fixed, the `testdata/` SQL files serve as a regression suite. `test_permanent_corpus` runs automatically with `cargo test` (no network required) and fails if any of those statements stop passing.

```sh
# Runs automatically — no flags needed
cargo test -p sqlfmt-corpus-tests
```

**Adding a new corpus source:**

1. Add a struct to `crates/sqlfmt-corpus-tests/src/sources.rs` implementing `CorpusSource` (wrap a `GithubFetcher` with the owner/repo/path/format config).
2. Add it to `all_sources()` in `crates/sqlfmt-corpus-tests/tests/corpus.rs`.

### Adding a new dialect

Implement `sqlfmt_core::Dialect` (two methods: `parse` and `ast_equal`), convert the dialect's AST to `sqlfmt_ir::Node`, and register it in `src/main.rs`.
