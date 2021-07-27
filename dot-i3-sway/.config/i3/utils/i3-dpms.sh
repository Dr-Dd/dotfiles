#!/bin/sh

# = XSS-LOCK PSEUDO CODE: =
#
# run pre_lock_actions
# if XSS_SLEEP_LOCK_FD exists then
#	kill -0 i3lock on SIGTERM and SIGINT
#	// close eventual old fd
#	run i3lock with close XSS_SLEEP_LOCK_FD 
#	// close new fd
#	close XSS_SLEEP_LOCK_FD 
#	while i3lock is killable do
#		sleep 0.5
#	done
# else // no XSS_SLEEP_LOCK_FD
#	kill SIGTERM background i3lock on SIGTERM and SIGINT
#	fork run i3lock --foreground-mode
#	wait
# fi
# run post_lock_actions
#
# = DPMS PSEUDO CODE: =
#
# (run screen_light(ON)) on SIGHUP and SIGINT and SIGTERM
# run screen_light(control = enable)
# run screen_light(OFF, delay = 5sec)
# run i3lock --foreground-mode
# run screen_light(ON)

echo "[`date '+%H:%M:%S'`] Starting `basename "$0"`"

# Pre lock commands:
# Stop all MPRIS playback
playerctl stop && echo "[`date '+%H:%M:%S'`] Stopped MPRIS playback"
# grab and blur screenshot
scrot -o /var/tmp/i3lock.png && echo "[`date '+%H:%M:%S'`] Saved screenshot with scrot"
convert /var/tmp/i3lock.png -blur 0x8 /var/tmp/i3lock.png && echo "[`date '+%H:%M:%S'`] Blurred screenshot with ImageMagick"
# enable dpms
xset +dpms dpms 5 5 5  && echo "[`date '+%H:%M:%S'`] Set dpms with xset"
# lock ttys
#physlock && echo "[`date '+%H:%M:%S'`] Locked ttys with physlock"

# Hot spot
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
	trap "echo '[`date '+%H:%M:%S'`] Killing i3lock'; pkill -xu ${EUID} -0 i3lock" TERM INT
	i3lock --debug -i /var/tmp/i3lock.png -e -f {XSS_SLEEP_LOCK_FD}<&- && echo "[`date '+%H:%M:%S'`] Locked screen and closed old fd"
	exec {XSS_SLEEP_LOCK_FD}<&- && echo "[`date '+%H:%M:%S'`] Locked screen and closed new fd"
	while "pkill -xu ${EUID} -0 i3lock"; do
		echo "[`date '+%H:%M:%S'`] Killed i3lock inside while"
		sleep 0.5
	done
else
	trap "kill %%" TERM INT
	i3lock --debug -i /var/tmp/i3lock.png -n -e -f &
	echo "[`date '+%H:%M:%S'`] Locked screen forking foreground"
	wait
fi

# Post lock commands:
# disable dpms
xset dpms 0 0 0 && echo "[`date '+%H:%M:%S'`] Disabled dpms timers"
