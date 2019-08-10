#!/bin/bash
#
# This script stows all the stow-able config files in this folder, use with caution

home-files=(
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

root-files=(
  pacman
  systemd
  xorg.conf
)

# Update home folder files
for i in "${home-files[@]}"
do
  stow "$i"
done

# Update root folder files
for i in "${root-files[@]}"
do
  stow -t / "$i"
done
