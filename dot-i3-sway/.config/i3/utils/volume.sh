#!/bin/sh

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
	amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
	amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
	volume=`get_volume`
	# Send the notification
	notify-send -i stock_volume -t 1000 -h string:x-dunst-stack-tag:volume -h int:value:$volume "Volume:"
}

case $1 in
	up)
		# Set the volume on (if it was muted)
		amixer -D pulse set Master on > /dev/null
		# Up the volume (+ 5%)
		amixer -D pulse sset Master 5%+ > /dev/null
		send_notification
		;;
	down)
		amixer -D pulse set Master on > /dev/null
		amixer -D pulse sset Master 5%- > /dev/null
		send_notification
		;;
	mute)
		# Toggle mute
		amixer -D pulse set Master 1+ toggle > /dev/null
		if is_mute ; then
			notify-send -i "audio-volume-muted" -h string:x-dunst-stack-tag:volume "Volume: muted"
		else
			send_notification
		fi
		;;
esac

