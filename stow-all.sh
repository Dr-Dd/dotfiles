#!/bin/bash
#
# This script stows all the stow-able config files in this folder, use with caution

homefiles=(
  bash 
  dunst
  emacs
  git
  gtk
  keepassxc
  mpd
  ranger
  scripts
  stalonetray
  wallpaper
  xdotfiles
  xmobar
  xmonad
  xscreensaver
)

rootfiles=(
  pacman
  systemd
  xorg.conf
)

# Update home folder files
for i in "${homefiles[@]}"
do
  stow "$i"
done

# Uncomment this only if you know what you're doing
# Update root folder files
#for i in "${rootfiles[@]}"
#do
  #stow -t / "$i"
#done
