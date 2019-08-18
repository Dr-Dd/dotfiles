#!/bin/bash

while true; do
  if [ $(checkupdates | wc -l) -gt 0 ] ; then
    dunstify -t 0 -i /usr/share/icons/Adwaita/48x48/legacy/software-update-available.png -u "LOW" "PACMAN" "Updates available"
  fi
  sleep 30m
done

