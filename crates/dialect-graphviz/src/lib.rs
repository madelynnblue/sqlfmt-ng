use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

mod convert;

pub struct GraphvizDialect;

impl Dialect for GraphvizDialect {
    fn parse(&self, _sql: &str) -> Result<Node, SqlfmtError> {
        unimplemented!("Graphviz dialect not yet implemented")
    }

    fn ast_equal(&self, _sql: &str, _rendered: &str) -> Result<(), SqlfmtError> {
        unimplemented!()
    }
}
