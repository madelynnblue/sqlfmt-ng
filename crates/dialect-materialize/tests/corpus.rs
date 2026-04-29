use dialect_materialize::MaterializeDialect;
use std::path::Path;

fn testdata_dir() -> std::path::PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata")
}

/// Reads cached corpus files, formats each statement with the Materialize dialect, and updates
/// `testdata/failing/` and `testdata/success/` accordingly. New failures and regressions
/// cause a panic.
/// Run with `cargo test -p dialect-materialize -- --ignored test_external_corpus`.
#[test]
#[ignore]
fn test_external_corpus() {
    sqlfmt_corpus_tests::run_external_corpus(
        &MaterializeDialect,
        &testdata_dir(),
        &sqlfmt_corpus_tests::corpus_cache_dir(),
    );
}

/// Scans `testdata/failing/` and moves any statement that now formats successfully into
/// `testdata/success/`. Panics if any statements were moved so you know to commit the changes.
/// Run with `cargo test -p dialect-materialize -- --ignored test_rewrite_corpus`.
#[test]
#[ignore]
fn test_rewrite_corpus() {
    sqlfmt_corpus_tests::run_rewrite_corpus(&MaterializeDialect, &testdata_dir());
}

/// Validates that all statements in `testdata/success/` format without error and all statements
/// in `testdata/failing/` still produce a Roundtrip or Parse error.
#[test]
fn test_permanent_corpus() {
    sqlfmt_corpus_tests::run_permanent_corpus(&MaterializeDialect, &testdata_dir());
}
