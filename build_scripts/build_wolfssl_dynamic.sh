#! /bin/bash
# minimal libcurl + wolfssl (see build_wolfssl_libs.sh), swapped in via LD_LIBRARY_PATH
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release
