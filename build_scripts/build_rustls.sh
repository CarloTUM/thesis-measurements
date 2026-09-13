#! /bin/bash
# vendored libcurl with rustls backend
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release --features rustls
