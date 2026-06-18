use std::path::Path;

pub mod corpus;
pub mod github;
pub mod graphviz;
pub mod slt;
pub mod sources;
pub mod sql;

pub use corpus::{corpus_cache_dir, run_external_corpus, run_permanent_corpus, run_rewrite_corpus};

pub trait CorpusSource: Send + Sync {
    fn name(&self) -> &str;
    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>>;
}
