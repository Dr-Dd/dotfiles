#!/bin/sh

trap "exit 0" TERM INT
trap "light -I; kill %%" EXIT
light -O && light -S 1
sleep 2147483647 &
wait
