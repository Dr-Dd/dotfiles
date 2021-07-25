#!/bin/sh

case $1 in
	"lock")
		# Stop audio
		playerctl pause
		# Save brightness
		light -O
		# Brightness to 0
		light -S 0
		;;
	"resume")
		# Restore brightness to -O value
		light -I
		;;
	*)
		echo select either resume or lock
		exit 1
		;;
esac

