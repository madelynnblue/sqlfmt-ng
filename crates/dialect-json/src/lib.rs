use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct JsonDialect;

impl Dialect for JsonDialect {
    fn parse(&self, _input: &str) -> Result<Node, SqlfmtError> {
        todo!()
    }

    fn ast_equal(&self, _original: &str, _rendered: &str) -> Result<(), SqlfmtError> {
        todo!()
    }
}
