#!/bin/bash

read -p "Do you want to add this package to the package install script? [Y/n] " ans

case $ans in 
	Y|y) latestdate=$(((pacman -Qei | awk -F ": " '/Install Date/ { printf("%s\n", $2); }') | sort -k2n -k3M -k4 -k5) | tail -1)
	     lstpkg=$(pacman -Qei | awk -F ": " -v lst_date="$latestdate" '{ if( $1 ~ "Name") name=$2; if($2 == lst_date) print name;}')
	     sed -i  "s/\#EOArray/$lstpkg\n  \#EOArray/" /home/drd/.dotfiles/install-all.sh
	;; 
esac
