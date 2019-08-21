#!/bin/bash

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

# Some of these packages are commented since i'm not sure of what system config you might have, add and remove them according 
# to what you need
packages=(
  # [CAT] audio
  alsa-utils
  cantata
  mpc
  mpd 

  # [CAT] drivers/system utils
  grub
  os-prober
  pacman-contrib
  efibootmgr
  ntfs-3g
  p7zip
##  nvidia
##  nvidia-settings
##  bbswitch # remember to be part of the group bumblebee
##  bumblebee 
##  lib32-nvidia-utils
##  lib32-virtualgls
##  libva-mesa-driver
##  xf86-video-intel
##  mesa
##  tlp

  # [CAT] GUI
  arc-solid-gtk-theme
  qt5-styleplugins
  lightdm # remember to enable ligthdm.service, add `acpi_osi='!Windows 2015'` to kernel params if needed
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  redshift
  stalonetray
  xmobar
  xmonad
  xmonad-contrib
  xorg
  xorg-server
  xorg-apps
  xorg-xinit
  xscreensaver

  # [CAT] tty utils
  aspell-en
  bash-completion
  dmenu
  htop
  ranger
  rxvt-unicode
  rclone
  stow
  xterm
  vim
  w3m
  wget
  xautolock

  # [CAT] misc utils 
  gcolor3
  gucharmap
  speedcrunch
  xarchiver
# [AUR] caffeine-ng

  # [CAT] notification
  dunst
  
  # [CAT] development
  eclipse-jee
  emacs
  jdk8-openjdk
  maven
  virtualbox
  virtualbox-host-modules-arch
  virtualbox-guest-iso
# [AUR] eclipse-vrapper
# [AUR] spring-tool-suite

  # [CAT] mail
  evolution

  # [CAT] pictures
  feh
  imagemagick

  # [CAT] internet
  firefox
  network-manager-applet
  networkmanager
  nm-connection-editor
  qbittorrent

  # [CAT] security
  keepassxc
  tor
# [AUR] tor-browser

  # [CAT] video
  mpv

  # [CAT] fonts
  terminus-font
  ttf-dejavu
  ttf-inconsolata

  # [CAT] documents
  zathura
  zathura-djvu
  zathura-pdf-mupdf
)

## [MAIN]
echo "== RUN THIS SCRIPT AS ROOT =="
echo "Starting countdown"
for i in {5..1}
do
  echo "$i.."
  sleep 1
done
echo ".."
echo "Installing pacman packages..."
pacman -S --noconfirm --needed "${packages[@]}"
systemctl enable lightdm.service
echo "
Other things you should do:
  * Setup grub bootloader
  * Configure rclone to work with preferred cloud provider
  * Add data partitions to fstab
  * Edit boot parameters
  * Install gpu drivers (see arch-wiki)
  * Stow needed dotfiles (see README)
"
printf "Reboot now? (Y/n) "
read ans
case "$ans" in
 y|Y) shutdown -r now ;;
esac
