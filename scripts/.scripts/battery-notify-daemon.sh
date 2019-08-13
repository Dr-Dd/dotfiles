#!/bin/bash

# Battery notification daemon

while true; do
  if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 15 ] ; then
    dunstify -t 3000 -i /usr/share/icons/Adwaita/48x48/legacy/battery-caution.png -u CRITICAL "WARNING" "Battery nearly empty"
  fi
  sleep 10m
done
