#! /bin/bash
# record heap allocations of one instance, PWD is the instance directory
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../shared
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
heaptrack ../shared/weel_bin
