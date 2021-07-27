#!/bin/sh

echo "[`date '+%H:%M:%S'`] Starting `basename "$0"`"

if [ $XDG_SESSION_TYPE = "x11" ] ; then
	# React to systemd-logind events by locking
	xset -dpms
	xset s on
	xset s 300 300
	# Note, works ONLY with xss-lock -l active, right now
	# the script works 3/4 of the way, test a bit (it
	# repeats locking even after unlocking)
	xss-lock -v -l \
		-n $HOME/.config/i3/utils/lock-dimming.sh \
		-- $HOME/.config/i3/utils/i3-dpms.sh
elif [ $XDG_SESSION_TYPE = "wayland" ] ; then
	# Todo swayidle
	echo "FIXME"
fi
