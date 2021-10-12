#!/bin/sh

# Brightness notification: dunst

function get_brightness {
	light -G | sed 's/\(^[0-9]*\)\..*/\1/'
}

function brightness_notification {
	brightness=`get_brightness`
	dunstify -i "sunny" -t 1000 -h string:x-dunst-stack-tag:brightness -h int:value:$brightness "Brightness:" 
}

case $1 in
	up)
		light -A 5
		brightness_notification
		;;
	down)
		if [ $(get_brightness) -le 5 ] ; then
			light -S 1
		else
			light -U 5
		fi
		brightness_notification
		;;
	*)
		echo "Usage: $0 up | down "
		;;
esac
