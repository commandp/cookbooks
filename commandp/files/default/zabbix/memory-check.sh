#!/bin/bash
# ============================================================
#  Author: Jonny Lai / jonny.lai (at) commandp.com
#  Filename: memory-check.sh
#  Modified: 2016-10-24 15:47
#  Description: Monitoring process memory usage.
#
#   `ps aux` 結果中的 RSS (resident set size) 的單位是 KB，而 zabbix-
#   server 用的單位是 B，所以得多乘以 1024 才符合真實情況。
#
#  Reference:
#
#   1. linux - ps aux output meaning | Super User
#    - http://superuser.com/a/117921/205255
#
# ===========================================================

PROCESS_NAME="$1"
ps aux | grep $PROCESS_NAME | awk '{ sum=sum+$6 }; END { print sum*1024 }'

