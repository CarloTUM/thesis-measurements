#! /bin/bash
# upstream implementation (reqwest/rustls), run in the baseline checkout
RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release
