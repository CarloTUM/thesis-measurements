#! /bin/bash
# run one instance under time(1), PWD is the instance directory (contains opts.json)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../shared
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
/usr/bin/time -v ../shared/weel_bin
