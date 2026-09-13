#! /bin/bash
# cross compile a minimal libcurl (http/https only) against wolfssl
export CC=aarch64-linux-gnu-gcc
cd wolfssl-5.9.2-stable
./autogen.sh
./configure --host=aarch64-linux-gnu --prefix=$PWD/../out --enable-curl --disable-examples --disable-crypttests --disable-benchmark
make -j$(nproc)
make install
cd ../curl-8.14.1
LDFLAGS=-L$PWD/../out/lib CPPFLAGS=-I$PWD/../out/include ./configure --host=aarch64-linux-gnu --prefix=$PWD/../out \
  --with-wolfssl=$PWD/../out --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt \
  --disable-ftp --disable-file --disable-ldap --disable-ldaps --disable-rtsp --disable-dict \
  --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smtp --disable-gopher \
  --disable-mqtt --disable-smb --disable-manual --disable-ntlm --disable-tls-srp --disable-ares \
  --without-libpsl --without-zlib --without-brotli --without-zstd --without-libidn2 --without-nghttp2
make -j$(nproc)
make install
aarch64-linux-gnu-strip ../out/lib/libcurl.so.4.8.0 ../out/lib/libwolfssl.so.45.0.0
