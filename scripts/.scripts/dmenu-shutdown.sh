#!/bin/bash

choice=$(echo -e "cancel\nshutdown\nreboot\nsuspend\nhibernate" | dmenu -i -fn "Monospace-10:antialias=false" -p "Choose an action" -sb "#AB4642")

case "$choice" in
  shutdown) shutdown -h now & ;;
  reboot) shutdown -r now & ;;
  suspend) systemctl suspend & ;;
  hibernate) systemctl hibernate & ;;
esac
