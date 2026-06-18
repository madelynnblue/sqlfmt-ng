use std::io::Read;

/// A preprocessor that can transform input data before dialect parsing.
///
/// `try_decode` returns `Some(decoded_bytes)` if this preprocessor can
/// decode the data, or `None` if the data isn't in this format.
pub trait Preprocessor: Send + Sync {
    fn name(&self) -> &'static str;
    fn try_decode(&self, data: &[u8]) -> Option<Vec<u8>>;
}

// ---------------------------------------------------------------------------
// Base64
// ---------------------------------------------------------------------------

pub struct Base64Preprocessor;

impl Preprocessor for Base64Preprocessor {
    fn name(&self) -> &'static str {
        "base64"
    }

    fn try_decode(&self, data: &[u8]) -> Option<Vec<u8>> {
        use base64::Engine as _;

        // Strip ASCII whitespace before decoding — base64 can have line breaks.
        let mut stripped: Vec<u8> = data
            .iter()
            .copied()
            .filter(|b| !b.is_ascii_whitespace())
            .collect();

        if stripped.is_empty() {
            return None;
        }

        // Try the strict STANDARD engine first (requires correct padding).
        if let Ok(decoded) = base64::engine::general_purpose::STANDARD.decode(&stripped) {
            return Some(decoded);
        }

        // Some encoders produce base64 with excess padding (e.g. a spurious
        // trailing '=' after a full group). Strip all padding chars and
        // re-decode with the no-pad engine, which accepts unpadded input.
        while stripped.last() == Some(&b'=') {
            stripped.pop();
        }

        base64::engine::general_purpose::STANDARD_NO_PAD
            .decode(&stripped)
            .ok()
    }
}

// ---------------------------------------------------------------------------
// Gzip
// ---------------------------------------------------------------------------

pub struct GzipPreprocessor;

impl Preprocessor for GzipPreprocessor {
    fn name(&self) -> &'static str {
        "gzip"
    }

    fn try_decode(&self, data: &[u8]) -> Option<Vec<u8>> {
        // Check gzip magic bytes: 0x1f 0x8b
        if data.len() < 2 || data[0] != 0x1f || data[1] != 0x8b {
            return None;
        }

        let mut decoder = flate2::read::GzDecoder::new(data);
        let mut buf = Vec::new();
        decoder.read_to_end(&mut buf).ok()?;

        // Reject empty decompressed result: we'd need the magic bytes to
        // match by chance AND the stream to be valid gzip AND decompress
        // to nothing. In that case the input is almost certainly not gzip,
        // but if it genuinely is a zero-payload gzip file, the pass-through
        // will produce a parse error either way (empty SQL doesn't parse).
        if buf.is_empty() {
            return None;
        }

        Some(buf)
    }
}

// ---------------------------------------------------------------------------
// Preprocessing loop
// ---------------------------------------------------------------------------

/// The ordered list of preprocessors. Order matters: base64 decoding is
/// tried first, then gzip decompression. This means `base64 → gzip` works
/// (the common case: base64 of gzip-compressed SQL), and so does
/// `gzip` alone.
pub const DEFAULT_PREPROCESSORS: &[&dyn Preprocessor] =
    &[&Base64Preprocessor, &GzipPreprocessor];

/// Apply preprocessors repeatedly until none succeed or all are exhausted.
///
/// Each preprocessor is *applied* at most once — it is removed from
/// consideration after a successful decode. A preprocessor that does not
/// match on one pass is re-tried on subsequent passes if other
/// preprocessors changed the data in between.
///
/// Returns the (possibly decoded) UTF-8 text and the names of the
/// preprocessors that were applied, in order.
///
/// Non-UTF-8 output: if a preprocessor produces bytes that aren't valid
/// UTF-8, replacement characters (U+FFFD) are inserted via
/// `String::from_utf8_lossy`. The dialect parser will then produce a
/// parse error — opaque, but this trade-off keeps preprocessing
/// transparent to callers.
pub fn preprocess(input: &[u8], preprocessors: &[&dyn Preprocessor]) -> (String, Vec<String>) {
    let mut data = input.to_vec();
    let mut available: Vec<usize> = (0..preprocessors.len()).collect();
    let mut steps: Vec<String> = Vec::new();

    loop {
        let mut applied = false;
        let mut i = 0;
        while i < available.len() {
            let idx = available[i];
            if let Some(decoded) = preprocessors[idx].try_decode(&data) {
                data = decoded;
                steps.push(preprocessors[idx].name().to_string());
                available.remove(i);
                applied = true;
                break;
            }
            i += 1;
        }
        if !applied || available.is_empty() {
            break;
        }
    }

    (String::from_utf8_lossy(&data).into_owned(), steps)
}

#[cfg(test)]
mod tests {
    use super::*;
    use base64::Engine as _;
    use std::io::Write;

    // -- individual preprocessor tests -----------------------------------

    #[test]
    fn base64_decodes_valid() {
        let input = base64::engine::general_purpose::STANDARD.encode(b"SELECT 1;");
        let result = Base64Preprocessor.try_decode(input.as_bytes());
        assert_eq!(result, Some(b"SELECT 1;".to_vec()));
    }

    #[test]
    fn base64_none_on_plain_sql() {
        // Random SQL shouldn't decode as base64.
        let result = Base64Preprocessor.try_decode(b"SELECT a FROM t;");
        assert!(result.is_none());
    }

    #[test]
    fn base64_strips_whitespace() {
        let encoded = base64::engine::general_purpose::STANDARD.encode(b"SELECT 1;");
        let with_newlines = format!("{encoded}\n");
        let result = Base64Preprocessor.try_decode(with_newlines.as_bytes());
        assert_eq!(result, Some(b"SELECT 1;".to_vec()));
    }

    #[test]
    fn gzip_decodes_valid() {
        let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
        gz.write_all(b"SELECT 1;").unwrap();
        let compressed = gz.finish().unwrap();

        let result = GzipPreprocessor.try_decode(&compressed);
        assert_eq!(result, Some(b"SELECT 1;".to_vec()));
    }

    #[test]
    fn gzip_none_on_plain_sql() {
        let result = GzipPreprocessor.try_decode(b"SELECT a FROM t;");
        assert!(result.is_none());
    }

    #[test]
    fn gzip_none_on_empty_data() {
        let result = GzipPreprocessor.try_decode(b"");
        assert!(result.is_none());
    }

    #[test]
    fn gzip_none_on_short_data_with_magic() {
        // Just the magic bytes, not a real gzip stream.
        let result = GzipPreprocessor.try_decode(&[0x1f, 0x8b]);
        assert!(result.is_none(), "should reject magic-byte-only data");
    }

    // -- preprocess loop tests -------------------------------------------

    #[test]
    fn plain_sql_passes_through() {
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let (out, steps) = preprocess(b"SELECT a FROM t;", &preprocessors);
        assert_eq!(out, "SELECT a FROM t;");
        assert!(steps.is_empty());
    }

    #[test]
    fn base64_single_pass() {
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let encoded = base64::engine::general_purpose::STANDARD.encode(b"SELECT 1;");
        let (out, steps) = preprocess(encoded.as_bytes(), &preprocessors);

        assert_eq!(out, "SELECT 1;");
        assert_eq!(steps, vec!["base64"]);
    }

    #[test]
    fn gzip_single_pass() {
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
        gz.write_all(b"SELECT 1;").unwrap();
        let compressed = gz.finish().unwrap();

        let (out, steps) = preprocess(&compressed, &preprocessors);

        assert_eq!(out, "SELECT 1;");
        assert_eq!(steps, vec!["gzip"]);
    }

    #[test]
    fn base64_then_gzip() {
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
        gz.write_all(b"SELECT 1;").unwrap();
        let compressed = gz.finish().unwrap();

        let encoded = base64::engine::general_purpose::STANDARD.encode(&compressed);

        let (out, steps) = preprocess(encoded.as_bytes(), &preprocessors);

        assert_eq!(out, "SELECT 1;");
        assert_eq!(steps, vec!["base64", "gzip"]);
    }

    #[test]
    fn base64_then_gzip_in_wrong_order_still_works() {
        // If the preprocessors were listed gzip-first, the base64+gzip input
        // would first try gzip (fails on base64 text), then base64 (succeeds),
        // then gzip on the decoded bytes (succeeds) — still works.
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&GzipPreprocessor, &Base64Preprocessor];

        let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
        gz.write_all(b"SELECT 1;").unwrap();
        let compressed = gz.finish().unwrap();

        let encoded = base64::engine::general_purpose::STANDARD.encode(&compressed);

        let (out, steps) = preprocess(encoded.as_bytes(), &preprocessors);

        assert_eq!(out, "SELECT 1;");
        // With gzip first: base64 text fails gzip check (no magic),
        // then base64 decode succeeds, then gzip decompresses.
        assert_eq!(steps, vec!["base64", "gzip"]);
    }

    #[test]
    fn stops_when_nothing_matches() {
        // After base64 decode produces plain SQL, gzip won't match.
        // The loop should stop after one pass, not endlessly retry.
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let encoded = base64::engine::general_purpose::STANDARD.encode(b"SELECT 1;");
        let (out, steps) = preprocess(encoded.as_bytes(), &preprocessors);

        assert_eq!(out, "SELECT 1;");
        assert_eq!(steps.len(), 1);
        assert_eq!(steps, vec!["base64"]);
    }

    #[test]
    fn empty_input_passes_through() {
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        let (out, steps) = preprocess(b"", &preprocessors);
        assert_eq!(out, "");
        assert!(steps.is_empty());
    }

    #[test]
    fn empty_preprocessor_list() {
        let preprocessors: Vec<&dyn Preprocessor> = vec![];
        let (out, steps) = preprocess(b"SELECT 1;", &preprocessors);
        assert_eq!(out, "SELECT 1;");
        assert!(steps.is_empty());
    }

    #[test]
    fn base64_with_excess_padding() {
        // Some encoders produce base64 with excess trailing '='.
        // The preprocessor should handle this gracefully.
        let preprocessors: Vec<&dyn Preprocessor> =
            vec![&Base64Preprocessor, &GzipPreprocessor];

        // Gzip-compress, base64-encode, then add an extra '='
        let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
        gz.write_all(b"SELECT 1;").unwrap();
        let compressed = gz.finish().unwrap();
        let mut encoded = base64::engine::general_purpose::STANDARD.encode(&compressed);
        // Add excess padding
        encoded.push('=');

        let (out, steps) = preprocess(encoded.as_bytes(), &preprocessors);
        assert_eq!(out, "SELECT 1;");
        assert_eq!(steps, vec!["base64", "gzip"]);
    }

    #[test]
    fn binary_output_from_preprocess_is_lossy() {
        let binary = vec![0x00, 0xFF, 0xFE]; // invalid UTF-8
        let encoded = base64::engine::general_purpose::STANDARD.encode(&binary);
        let (out, steps) = preprocess(encoded.as_bytes(), &[&Base64Preprocessor]);
        assert_eq!(steps, vec!["base64"]);
        // The lossy conversion should have replacement chars.
        assert!(out.contains('\u{FFFD}'));
    }
}
