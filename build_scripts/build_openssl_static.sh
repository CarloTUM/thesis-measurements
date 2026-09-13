#! /bin/bash
# libcurl + openssl vendored, statically linked into libweel_lib.so
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release --features static-curl,static-ssl
