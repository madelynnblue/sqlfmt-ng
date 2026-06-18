use dialect_graphviz::GraphvizDialect;
use std::path::Path;

fn testdata_dir() -> std::path::PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata")
}

#[test]
#[ignore]
fn test_external_corpus() {
    sqlfmt_corpus_tests::run_external_corpus(
        &GraphvizDialect,
        &testdata_dir(),
        &sqlfmt_corpus_tests::corpus_cache_dir(),
    );
}

#[test]
#[ignore]
fn test_rewrite_corpus() {
    sqlfmt_corpus_tests::run_rewrite_corpus(&GraphvizDialect, &testdata_dir());
}

#[test]
fn test_permanent_corpus() {
    sqlfmt_corpus_tests::run_permanent_corpus(&GraphvizDialect, &testdata_dir());
}
