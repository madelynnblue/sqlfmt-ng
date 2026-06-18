use sqlfmt_core::Dialect;
use sqlfmt_error::SqlfmtError;
use sqlfmt_ir::Node;

mod convert;

pub struct GraphvizDialect;

impl Dialect for GraphvizDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let _ = sql;
        todo!("parse")
    }

    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError> {
        let _ = (sql, rendered);
        todo!("ast_equal")
    }
}
