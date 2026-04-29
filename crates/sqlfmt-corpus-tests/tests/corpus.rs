use sqlfmt_corpus_tests::sources::all_sources;
use std::path::Path;

/// Downloads raw corpus files from external sources (Materialize, PostgreSQL, CockroachDB)
/// into `testdata/corpus-cache/`. Re-run this when you want to refresh the cached sources.
/// Run with `cargo test -p sqlfmt-corpus-tests -- --ignored test_download_corpus`.
#[test]
#[ignore]
fn test_download_corpus() {
    let cache_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata/corpus-cache");
    for source in &all_sources() {
        match source.fetch(&cache_dir) {
            Ok(stmts) => println!("{}: {} statements", source.name(), stmts.len()),
            Err(e) => panic!("failed to fetch {}: {}", source.name(), e),
        }
    }
}
