# This .xinitrc is used only in the case where x is started from tty or if the display manager sources it (which is bad practice or sign
# of an old display manager like SLiM). For this reason it has to be synced with .xprofile (maybe sourcing it would be smarter, we'll se# e)
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ ! -s ~/.config/mpd/pid ] && mpd &
~/.scripts/battery-notify-daemon.sh &
~/.scripts/check-updates-daemon.sh &
stalonetray &
redshift-gtk &
nm-applet &
caffeine &
xautolock -time 5 -locker "systemctl suspend" &
sleep 5 && xscreensaver -no-splash &
exec xmonad
