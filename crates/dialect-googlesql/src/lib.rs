use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct GoogleSqlDialect;

impl Dialect for GoogleSqlDialect {
    fn parse(&self, _sql: &str) -> Result<Node, SqlfmtError> {
        unimplemented!("GoogleSQL dialect not yet implemented (Phase 2)")
    }
    fn ast_equal(&self, _sql: &str, _rendered: &str) -> Result<(), SqlfmtError> {
        unimplemented!()
    }
}
