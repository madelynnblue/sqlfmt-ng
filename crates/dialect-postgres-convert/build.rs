fn main() {
    let proto_dir = std::path::Path::new("proto");
    prost_build::compile_protos(&[proto_dir.join("pg_query.proto")], &[proto_dir])
        .expect("failed to compile pg_query.proto");
    println!("cargo:rerun-if-changed=proto/pg_query.proto");
}
