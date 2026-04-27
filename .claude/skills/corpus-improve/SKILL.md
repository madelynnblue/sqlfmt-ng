---
name: corpus-improve
description: Use when asked to improve corpus test coverage for a dialect, run corpus tests, or fix round-trip failures. Accepts a dialect name argument (postgres, materialize, cockroachdb) and drives the loop of running tests, diagnosing failures, fixing IR conversion code, and updating testdata.
---

# corpus-improve

Iteratively improve a dialect's round-trip correctness by running the external corpus, diagnosing failures, fixing the IR converter, and committing known failures to testdata.

## Dialect → Corpus → Converter mapping

| Dialect       | Corpus source repo                                                | Test files   | Converter                                             |
| ------------- | ----------------------------------------------------------------- | ------------ | ----------------------------------------------------- |
| `postgres`    | `postgres/postgres` `src/test/regress/sql/*.sql`                  | raw SQL      | `crates/dialect-postgres-convert/src/json_convert.rs` |
| `materialize` | `MaterializeInc/materialize` `test/sqllogictest/*.slt`            | sqllogictest | `crates/dialect-materialize/src/convert.rs`           |
| `cockroachdb` | `cockroachdb/cockroach` `pkg/sql/logictest/testdata/logic_test/*` | sqllogictest | _(stub — not yet implemented)_                        |

## Workflow

### 1. Triage failures

Choose the first failure in `crates/sqlfmt-corpus-tests/testdata/failing/{corpus}-{dialect}.sql`, then:

```sh
# Format one failing statement to see the error
cargo run -- --dialect <dialect> --stmt "<paste stmt here>"
# or
echo "<stmt>" | cargo run -- --dialect <dialect>
```

The error should be:

- `SqlfmtError::Roundtrip` — IR conversion is lossy; something dropped from the AST

Find another statement if not and restart.

### 2. Diagnose a round-trip failure

A `Roundtrip` error means the rendered SQL re-parses to a different AST than the original. Find what's being lost:

1. Look up the relevant AST node in the parser's JSON output (postgres: use `pg_query::parse_to_json(stmt)`)
2. Search `json_convert.rs` (postgres) or `convert.rs` (materialize) for the node type
3. Check whether any fields are missing from the IR construction — common causes:
   - A `TODO` comment returning `Node::Text` instead of a real conversion
   - A match arm that ignores fields (e.g., `OrderByClause` missing `NULLS FIRST/LAST`)
   - A new AST node variant added upstream that has no arm

### 3. Fix the converter

Edit the appropriate converter file and add or complete the conversion for the failing node. After fixing:

```sh
# Verify the specific statement now passes
cargo run -- --dialect <dialect> --stmt "<stmt>"

# Run the rewriter to move now-passing statements from failing/ to success/
# (uses -- --ignored because the test is #[ignore]d — it mutates testdata files)
cargo test -p sqlfmt-corpus-tests test_rewrite_corpus -- --ignored

# Run permanent corpus test (fast, no network) to verify both dirs
cargo test -p sqlfmt-corpus-tests test_permanent_corpus
```

### 4. Move fixed statements to success/

After fixing a class of failures, run `test_rewrite_corpus` to automatically move all now-passing statements from `crates/sqlfmt-corpus-tests/testdata/failing/` to `crates/sqlfmt-corpus-tests/testdata/success/`. The test panics when statements are moved, signaling you to commit the updated testdata.

The `test_permanent_corpus` test then ensures:

- `crates/sqlfmt-corpus-tests/testdata/success/` statements remain passing (regression prevention)
- `crates/sqlfmt-corpus-tests/testdata/failing/` statements still produce round-trip errors (still need fixing)

If a statement still fails and the fix is complex, leave it in `crates/sqlfmt-corpus-tests/testdata/failing/` as a known failure and move to the next one.

After the statement (and possibly others) have been moved to success, commit the changes and start a new change. Try to keep it to one change per commit. Sometimes multiple fixes will be required for a single statement to move to succes if that statement has multiple broken things; that's ok.

### 5. Commit

After the permanent corpus test passes, set a jj commit description summarizing the converter fixes. Then start a new change with `jj new`.

## Running a single corpus test quickly

To diagnose a specific failing statement without re-running the full corpus:

```sh
cargo run -- --dialect postgres --stmt "SELECT a AT TIME ZONE 'UTC' FROM t"
```

## Testdata directory structure

```
crates/sqlfmt-corpus-tests/testdata/
  failing/
    {corpus}-{dialect}.sql    — known round-trip failures
  success/
    {corpus}-{dialect}.sql    — verified passing statements (regression suite)
```

### Testdata file format

```sql
SELECT a FROM t

-- sqlfmt-corpus-separator --

SELECT b, c FROM t WHERE x > 1
```

Statements are separated by `\n\n-- sqlfmt-corpus-separator --\n\n`. Each statement is trimmed before comparison, so whitespace-only differences don't create duplicates.

### Three test tiers

| Test                    | Command                                                              | What it does                                                                                        |
| ----------------------- | -------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `test_external_corpus`  | `cargo test -p sqlfmt-corpus-tests -- --ignored`                     | Fetches live SQL from upstream repos, writes new failures to `failing/` and successes to `success/` |
| `test_rewrite_corpus`   | `cargo test -p sqlfmt-corpus-tests test_rewrite_corpus -- --ignored` | Scans `failing/`, moves passing statements to `success/`, panics on changes                         |
| `test_permanent_corpus` | `cargo test -p sqlfmt-corpus-tests test_permanent_corpus`            | Verifies `success/` stays passing and `failing/` still fails                                        |
