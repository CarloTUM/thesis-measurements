#! /bin/bash
# minimal libcurl + wolfssl, statically linked via pkg-config
# expects the out/ of build_wolfssl_libs.sh as minicurl/ in the checkout
# (cross mounts the checkout at /project inside the container)
DOCKER_OPTS='-e PKG_CONFIG_PATH=/project/minicurl/lib/pkgconfig:/usr/lib/aarch64-linux-gnu/pkgconfig -e LIBCURL_STATIC=1 -e PKG_CONFIG_ALLOW_CROSS=1' RUSTFLAGS='-C prefer-dynamic' cross build --target aarch64-unknown-linux-gnu --release
