use thiserror::Error;

#[derive(Debug, Error)]
pub enum SqlfmtError {
    #[error("parse error: {0}")]
    Parse(String),
    #[error("unformatted node in IR")]
    Unformatted,
    #[error("roundtrip error:\nInput:\n{input}\nRendered:\n{output}")]
    Roundtrip { input: String, output: String },
}
