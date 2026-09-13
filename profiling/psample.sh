#! /bin/bash
# sample rss/pss of all running instances from smaps_rollup during the pattern runs
OUT=$1
echo t,pid,rss_kb,pss_kb,priv_kb > $OUT
while true; do
  t=$(date +%s.%N)
  for p in $(pgrep -x weel_bin); do
    awk -v t="$t" -v p="$p" '/^Rss:/{r=$2}/^Pss:/{s=$2}/^Private_Dirty:/{d=$2}END{print t","p","r","s","d}' /proc/$p/smaps_rollup 2>/dev/null
  done >> $OUT
  sleep 0.2
done
