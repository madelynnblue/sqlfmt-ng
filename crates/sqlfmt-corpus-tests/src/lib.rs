use std::path::Path;

pub mod github;
pub mod slt;
pub mod sources;
pub mod sql;

pub trait CorpusSource: Send + Sync {
    fn name(&self) -> &str;
    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>>;
}
