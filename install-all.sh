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
  alsa-utils
  arc-solid-gtk-theme
  aspell-en
  bash-completion
 # bbswitch # remember to be part of the group bumblebee
 # bumblebee 
  cantata
  dmenu
  dunst
  eclipse-jee
 # efibootmgr
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
 # lib32-nvidia-utils
 # lib32-virtualgls
 # libva-mesa-driver
  lightdm # remember to enable ligthdm.service, add `acpi_osi='!Windows 2015'` to kernel params if needed
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  maven
 # mesa
  mpc
  mpd 
  mpv
  network-manager-applet
  networkmanager
  nm-connection-editor
  ntfs-3g
 # nvidia
 # nvidia-settings
  os-prober
  p7zip
  qbittorrent
  qt5-styleplugins
  ranger
  rclone
  redshift
  rxvt-unicode
  speedcrunch
  stalonetray
  stow
  terminus-font
 # tlp
  ttf-dejavu
  ttf-inconsolata
  vim
  virtualbox
  virtualbox-host-modules-arch
  virtualbox-guest-iso
  w3m
  wget
  xarchiver
  xautolock
 # xf86-video-intel
  xmobar
  xmonad
  xmonad-contrib
  xorg
  xorg-server
  xorg-apps
  xorg-xinit
  xscreensaver
  zathura
  zathura-djvu
  zathura-pdf-mupdf
)

## "Main"
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
