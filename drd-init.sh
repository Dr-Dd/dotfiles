#!/usr/bin/env bash

# == PARTITIONING SCHEME ==
# 
# Mount | Size            | Type | Primary
# /     | (23 + sqrt 23)G | ext4 | yes
# /home | (62 + sqrt 62)G | ext4 | yes
# /usr  | (27 + sqrt 27)G | ext4 | yes
# /swap | ( 8 + sqrt  8)G | swap | yes
# ----- | --------------- | ---- | ---
# TOT   | l41G -> 150G    | n/a  | n/a
#
# In reality, i tend to only use a single root partition since i rely on dotfiles

packages=(
  alsa-utils
  arc-solid-gtk-theme
  bash-completion
  bbswitch # remember to be part of the group bumblebee
  bumblebee 
  cantata
  dmenu
  dunst
  eclipse-jee
  efibootmgr
  emacs
  evolution
  feh
  firefox
  gcolor3
  grub
  gucharmap
  htop
  jdk8-openjdk
  keepassxc
  lib32-nvidia-utils
  lib32-virtualgls
  lightdm # remember to enable ligthdm.service, add acpi_osi='!Windows 2015' to kernel params
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  maven
  mpc
  mpd 
  mpv
  network-manager-applet
  networkmanager
  nm-connection-editor
  ntfs-3g
  nvidia
  nvidia-settings
  os-prober
  qbittorrent
  ranger
  rclone
  redshift
  rxvt-unicode
  stalonetray
  stow
  terminus-font
  tlp
  ttf-dejavu
  ttf-inconsolata
  vim
  w3m
  wget
  xarchiver
  xautolock
  xf86-video-intel
  xmobar
  xmonad
  xmonad-contrib
  xorg
  xorg-server
  xorg-apps
  xscreensaver
  zathura
  zathura-djvu
  zathura-pdf-mupdf
)

install-packages {
  ## One command per package since it 'ignores' failed installs
  for i in "${packages[@]}"
  do
    sudo pacman -S --noconfirm "${i}"
  done
}

## "Main"
echo 'Run this script only if you have already stowed some needed pacman dotfiles'
echo 'You have 5 seconds to stop the init process'
sleep 1
echo '.'
sleep 1
echo '.'
sleep 1
echo '.'
sleep 1
echo '.'
sleep 1
echo '.'
echo 'Installing pacman packages...'
install-packages
echo '
Other things you should do:
  * Configure rclone to work with MEGA
  * Add data partitions to fstab
  * Stow needed dotfiles (remember that some dotfiles need the \"-t /\" target)
  * Start needed systemd services
  * Edit boot parameters
  * Configure gtk-greeter
'
