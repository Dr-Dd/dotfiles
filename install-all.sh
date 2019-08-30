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
  # audio
  alsa-utils
  cantata
  mpc
  mpd

  # drivers/system utils
  efibootmgr
  grub
  ntfs-3g
  os-prober
  p7zip
  pacman-contrib
##  bbswitch # remember to be part of the group bumblebee
##  bumblebee
##  lib32-nvidia-utils
##  lib32-virtualgls
##  libva-mesa-driver
##  mesa
##  nvidia
##  nvidia-settings
##  tlp
##  xf86-video-intel

  # GUI
  arc-solid-gtk-theme
  lightdm # remember to enable ligthdm.service, add `acpi_osi='!Windows 2015'` to kernel params if needed
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  qt5-styleplugins
  redshift
  stalonetray
  xmobar
  xmonad
  xmonad-contrib
  xorg
  xorg-apps
  xorg-server
  xorg-xinit
  xscreensaver

  # tty utils
  aspell-en
  bash-completion
  dmenu
  htop
  ranger
  rclone
  rxvt-unicode
  stow
  thefuck
  vim
  w3m
  wget
  xautolock
  xterm

  # misc utils
  gcolor3
  gucharmap
  speedcrunch
  xarchiver
# caffeine-ng [AUR] 

  # notification
  dunst

  # development
  clang
  eclipse-jee
  emacs
  jdk8-openjdk
  maven
  opam
  virtualbox
  virtualbox-guest-iso
  virtualbox-host-modules-arch
# eclipse-vrapper [AUR] 
# spring-tool-suite [AUR] 

  # mail
  evolution

  # pictures
  feh
  imagemagick
  scrot

  # internet
  firefox
  network-manager-applet
  networkmanager
  nm-connection-editor
  qbittorrent

  # security
  keepassxc
  tor
# tor-browser [AUR] 

  # video
  mpv

  # fonts
  adobe-source-han-sans-otc-fonts
  terminus-font
  ttf-dejavu
  ttf-inconsolata

  # documents
  zathura
  zathura-djvu
  zathura-pdf-mupdf
)

aur=(
  caffeine-ng
  chromium-widevine
  eclipse-vrapper
  spring-tool-suite
  tor-browser
)

## [MAIN]
echo "== RUN THIS SCRIPT AS ROOT =="

echo "==> Starting countdown"
for i in {5..1}
do
  echo "$i.."
  sleep 1
done
echo ".."

echo "==> Installing pacman packages..."
pacman -S --noconfirm --needed "${packages[@]}"

echo "==> Activating needed services..."
systemctl enable lightdm.service

echo "==> Updating and upgrading opam..."
runuser -l drd opam update
runuser -l drd opam upgrade
runuser -l drd opam install merlin
runuser -l drd opam user-setup install

echo "==> Downloading aur packages..."
for p in "${aur[@]}"
do
  runuser -l drd git clone "https://aur.archlinux.org/${p}.git" ~/.aur/
done

echo "==> Installing aur packages..."
for p in "${aur[@]}"
do
  runuser -l drd -c "cd ~/.aur/${p}"
  runuser -l drd -c "makepkg -si"
done

echo "
==> Other things you should do:
  * Setup grub bootloader
  * Configure rclone to work with preferred cloud provider
  * Add data partitions to fstab
  * Edit boot parameters
  * Install gpu drivers (see arch-wiki)
  * Stow needed dotfiles (see README)
"
printf "==> Reboot now? (Y/n) "
read ans
case "$ans" in
 y|Y) shutdown -r now ;;
esac
