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
# == INSTALLATION INSTRUCTIONS ==
#
# 1) Install /extra packages needed:
#    * xf86-video-nouveau-blacklist
#    * bash-completion
# 2) Switch to a generic kernel via mkinitrd
#    * Eventually add the required boot option to the uefi boot
#    * Don't forget to append the resume partition to the correct boot entry
# 3) Install proprietary nvidia driver
# 4) Run 'adduser' and add, well, a user
# 5) Setup sudo/shutdown, pm-utils for sudoers/user
# 6) Copy /usr/share/X11/xorg.conf.d/* required configs to /etc/X11/xorg.conf.d/
# 7) Connect to the web via NetworkManager (generally an applet)
# 8) Download and install slackpkg, slackpkg+, sbopkg
# 9) Blacklist/adjust all the needed conf files for package management
# 10) Make the system multilib enabled
# 11) Download install the following packages:
#    * xmonad
#    * xmobar
#    * stalonetray
#    * redshift
#    * keepassxc
#    * MEGA
#    * Inconsolata font
#    * SLiM (unmantained)
#      - optionally install slim themes
#    * urxvt
#    * dunst (difficult to manage)   
#    * caffeine
#    * xautolock
#    * TLP
# 12) Import all the config files to their respective locations
# 13) Maybe try a system update, you're set to go, take a look at "https://docs.slackware.com"

dotfiles=(
  ["~"]="{.bash_profile,.bashrc,.gitconfig,.stalonetrayrc,.gtkrc-2.0,.profile,.xinitrc,.xmobarrc,.Xmodmap,.xprofile,.Xresources,aur,scripts,.wallpaper,.xmonad}"
  ["~/.config"]="{dunst,gtk-3.0,mpd,rclone}"
  ["~/.emacs.d"]="{init.el}"
  ["/etc"]="{pacman.conf,sudoers}"
  ["/etc/default"]="{grub}"
  ["/etc/systemd"]="{logind.conf}"
  ["/etc/X11/xorg.conf.d"]="{00-keyboard.conf,20-intel.conf,40-libinput.conf}"
)

dot-location(
  ["~"]="~/dotfiles/dot-home"
  ["~/.config"]="~/dotfiles/dot-home/.config"
  ["~/.emacs.d"]="~/dotfiles/dot-home/.emacs.d"
  ["/etc"]="~/dotfiles/etc"
  ["/etc/default"]="~/dotfiles/etc/default"
  ["/etc/systemd"]="~/dotfiles/etc/systemd"
  ["/etc/X11/xorg.conf.d"]="~/dotfiles/etc/X11/xorg.conf.d"
)

packages=(
  alsa-utils
  arc-solid-gtk-theme
  bash-completion
  bbswitch
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
  lightdm
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

backup-dotfiles {
  for i in "${!dotfiles[@]}"
  do
    cd "$i"
    cp -r -i "${dotfiles[$i]}" "${dot-location[$i]}"
  done
}

export-dotfiles {
    for i in "${!dot-location[@]}"
    do
      cd "${dot-location[$i]}"
      cp -r -i * "$i"
    done  
}

## "Main"
