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
    zip
    ##bbswitch # remember to be part of the group bumblebee
    ##bumblebee
    ##lib32-nvidia-utils
    ##lib32-virtualgls
    ##libva-mesa-driver
    ##mesa
    ##nvidia
    ##nvidia-settings
    ##tlp
    ##xf86-video-intel

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
    #caffeine-ng [AUR]

    # notification
    dunst

    # development
    clang
    eclipse-jee
    emacs
    ghc-static
    jdk8-openjdk
    maven
    npm
    opam
    postgresql
    python-pip
    virtualbox
    virtualbox-guest-iso
    virtualbox-host-modules-arch
    android-tools
    libmtp
    #eclipse-vrapper [AUR]
    #spring-tool-suite [AUR]
    #merlin [OPAM]
    #sleekxmpp [PIP]

    # mail
    thunderbird

    # pictures
    feh
    imagemagick
    scrot

    # internet
    #firefox # Unfortunately Chromium has severe problems with bumblebee on my machine
    chromium
    network-manager-applet
    networkmanager
    nm-connection-editor
    qbittorrent

    # security
    keepassxc
    tor
    #tor-browser [AUR]

    # video
    mpv

    # fonts
    adobe-source-han-sans-otc-fonts
    terminus-font
    ttf-dejavu
    ttf-inconsolata
    ttf-joypixels

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

pip=(
    sleekxmpp
)

opam=(
    merlin
)

## [MAIN]

# colors
red=$(tput setaf 1)
off=$(tput sgr0)

echo "${red}== RUN THIS SCRIPT AS ROOT ==${off}"

########
# USER #
########
valid=false
while [ $valid = false ] ; do
    echo "${red}==>${off} For what user do you want to install local packages?"
    printf "${red}==>${off} User: "
    read usr
    printf "${red}==>${off} Confirm user: "
    read confirm
    if [ "${usr}" = "${confirm}" ] ; then
        valid=true
    fi
done

echo "${red}==>${off} Starting countdown"
for i in {5..1}; do
    echo "$i.."
    sleep 1
done
echo ".."

##########
# PACMAN #
##########
echo "${red}==>${off} Installing pacman packages..."
pacman -S --noconfirm --needed "${packages[@]}"

############
# SERVICES #
############
echo "${red}==>${off} Activating needed services..."
systemctl enable lightdm.service

############
# DOTFILES #
############
printf "${red}==>${off} Stow home-files?"
read ans
case "$ans" in
    y|Y) runuser -l "${usr}" -c "cd /home/${usr}/.dotfiles && stow home-*" ;;
    n|N) ;;
    *) echo "Please select a valid option" ;;
esac

#######
# AUR #
#######
echo "${red}==>${off} Downloading aur packages..."
for p in "${aur[@]}"; do
    runuser -l "${usr}" -c "git clone https://aur.archlinux.org/${p}.git /home/${usr}/.aur/"
done

echo "${red}==>${off} Installing aur packages..."
for p in "${aur[@]}"; do
    runuser -l "${usr}" -c "cd /home/${usr}/.aur/${p} && makepkg -si"
done

#######
# PIP #
#######
echo "${red}==>${off} Installing python packages via pip..."
for p in "${pip[@]}"; do
    runuser -l "${usr}" -c "pip install --user ${p}"
done

########
# OPAM #
########
echo "${red}==>${off} Updating / upgrading opam and installing needed packages..."
runuser -l "${usr}" -c "opam update"
runuser -l "${usr}" -c "opam upgrade"
for p in "${opam[@]}"; do
    runuser -l "${usr}" -c "opam install ${p}"
done
runuser -l "${usr}" -c "opam user-setup install"

echo "
${red}==>${off} Other things you should do:
  ${red}*${off} Setup grub bootloader
  ${red}*${off} Configure rclone to work with preferred cloud provider
  ${red}*${off} Add data partitions to fstab
  ${red}*${off} Edit boot parameters
  ${red}*${off} Install gpu drivers (see arch-wiki)
  ${red}*${off} Stow needed dotfiles (see README)
"

printf "${red}==>${off} Reboot now? (Y/n) "
read ans
case "$ans" in
    y|Y) shutdown -r now ;;
    n|N) ;;
    *) echo "Please select a valid option" ;;
esac
