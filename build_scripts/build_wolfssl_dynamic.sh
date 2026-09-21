#! /bin/bash
# minimal libcurl + wolfssl (see build_wolfssl_libs.sh), swapped in via LD_LIBRARY_PATH
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release
# the minimal libs go into shared/ next to the binary, under their SONAMEs
cp out/lib/libcurl.so.4.8.0 shared/libcurl.so.4
cp out/lib/libwolfssl.so.45.0.0 shared/libwolfssl.so.45
