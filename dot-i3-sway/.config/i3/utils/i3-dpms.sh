#!/bin/sh

revert() {
	xset dpms 0 0 0
}

trap revert HUP INT TERM
playerctl stop
xset +dpms dpms 5 5 5
convert x:root -blur 0x8 RGB:- | i3lock -n -e -f --raw 1920x1080:rgb -i /dev/stdin 
revert
