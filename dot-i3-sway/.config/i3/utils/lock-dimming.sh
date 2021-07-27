#!/bin/sh

echo "[`date '+%H:%M:%S'`] Starting `basename "$0"`"

trap "exit 0" TERM INT
trap "light -v 3 -I; kill %%; echo '[`date '+%H:%M:%S'`] Restored brightness'" EXIT
light -v 3 -O && light -v 3 -S 1
echo "[`date '+%H:%M:%S'`] Dimmed brightness and saved value"
sleep 2147483647 &
wait
