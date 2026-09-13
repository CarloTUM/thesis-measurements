#! /bin/bash
# scaling: per level N fresh instances parked in the station loop, 200s sampling at 1hz
# usage: ./scale_run.sh <variant> <model> [het]   (het: per-instance binary copy, nothing shared)
V=$1; M=$2; HET=$3
USED=0
for N in 1 5 10 25 50; do
  for D in $(ls -d $V/$M/[0-9]* | sort -t/ -k3 -n | sed -n "$((USED+1)),$((USED+N))p"); do
    BIN=$PWD/$V/$M/shared/weel_bin
    [ -n "$HET" ] && BIN=$PWD/$D/weel_bin
    systemd-run --user --quiet --unit=sc-$(basename $D) --working-directory=$PWD/$D --setenv=LD_LIBRARY_PATH=$PWD/$V/$M/shared --setenv=SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt $BIN
    sleep 0.5
  done
  USED=$((USED+N))
  sleep 15
  timeout 200 ./sample1hz.sh scale-$V$HET-$N.csv
  pkill -x weel_bin
  sleep 3
done
