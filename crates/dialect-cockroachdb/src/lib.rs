use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct CockroachDialect;

impl Dialect for CockroachDialect {
    fn parse(&self, _sql: &str) -> Result<Node, SqlfmtError> {
        unimplemented!("CockroachDB dialect not yet implemented (Phase 2)")
    }
}
