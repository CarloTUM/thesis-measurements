#! /bin/bash
# rebuild the minimal libcurl at -Os instead of -O2, same configure line as
# build_wolfssl_libs.sh, own prefix. stripped result: 530000 B vs 595544 B at -O2
export CC=aarch64-linux-gnu-gcc CFLAGS=-Os
cp -r curl-8.14.1 curl-os
cd curl-os
LDFLAGS=-L$PWD/../out/lib CPPFLAGS=-I$PWD/../out/include ./configure --host=aarch64-linux-gnu --prefix=$PWD/../out-os \
  --with-wolfssl=$PWD/../out --with-ca-bundle=/etc/ssl/certs/ca-certificates.crt \
  --disable-ftp --disable-file --disable-ldap --disable-ldaps --disable-rtsp --disable-dict \
  --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smtp --disable-gopher \
  --disable-mqtt --disable-smb --disable-manual --disable-ntlm --disable-tls-srp --disable-ares \
  --without-libpsl --without-zlib --without-brotli --without-zstd --without-libidn2 --without-nghttp2
make -j$(nproc)
make install
aarch64-linux-gnu-strip ../out-os/lib/libcurl.so.4.8.0
