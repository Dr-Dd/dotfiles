#!/bin/sh

# Brightness notification: dunst

function get_brightness {
	light -G | sed 's/\(^[0-9]*\)\..*/\1/'
}

function brightness_notification {
	brightness=`get_brightness`
	dunstify -i "null" -r 1337 -t 1000 "Brightness: $brightness%" 
}

case $1 in
	up)
		light -A 5
		brightness_notification
		;;
	down)
		light -U 5
		brightness_notification
		;;
	*)
		echo "Usage: $0 up | down "
		;;
esac
