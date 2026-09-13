#! /bin/bash
# sample rss/pss at 1hz for the scaling runs
OUT=$1
echo t,pid,rss_kb,pss_kb,priv_kb > $OUT
while true; do
  t=$(date +%s)
  for p in $(pgrep -x weel_bin); do echo /proc/$p/smaps_rollup; done \
  | xargs -r awk -v t="$t" '/^Rss:/{r=$2}/^Pss:/{s=$2}/^Private_Dirty:/{split(FILENAME,a,"/");print t","a[3]","r","s","$2}' >> $OUT 2>/dev/null
  sleep 1
done
