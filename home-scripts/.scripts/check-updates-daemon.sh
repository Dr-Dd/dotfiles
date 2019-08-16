#!/bin/bash

while true; do
  pacman -Qu > /dev/null 2>&1 # generate status code
  if [ $? -ne 1 ] ; then
    dunstify -t 5000 -i /usr/share/icons/Adwaita/48x48/legacy/system-software-update.png "pacman" "Updates available"
  fi
  sleep 30m
done
