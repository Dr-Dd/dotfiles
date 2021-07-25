#!/bin/sh

if [ $XDG_SESSION_TYPE = "x11" ] ; then
	# React to systemd-logind events by locking
	# NOTE: dpms works correctly 
	# (no manual dimming required)
	xset s on 
	xset s 300 300
	xss-lock \
		-n "$HOME/.config/i3/utils/lock-dimming.sh" \
		-- "$HOME/.config/i3/utils/i3-dpms.sh"
		
elif [ $XDG_SESSION_TYPE = "wayland" ] ; then
	# Todo swayidle
	echo "fixme"
fi
