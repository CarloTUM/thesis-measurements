#! /bin/bash
# curl http_helper against the system libcurl/openssl of the device
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release
