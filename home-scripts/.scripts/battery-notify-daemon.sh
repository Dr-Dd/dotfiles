#!/bin/bash

# Battery notification daemon

while true; do
  if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 15 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" ] ; then
    dunstify -t 5000 -i /usr/share/icons/Adwaita/48x48/legacy/battery-caution.png -u CRITICAL "WARNING" "Battery nearly empty"
  else 
    if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 10 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" ] ; then
      systemctl hibernate
    fi
  fi
  sleep 5m
done
