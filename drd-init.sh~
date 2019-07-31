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

