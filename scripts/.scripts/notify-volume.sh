#!/bin/bash
vol=$(amixer sget Master | grep -o -m 1 "[0-9]**%")
val=$(echo "$vol" | awk -F "%" '{print $1}' )
status=$(amixer sget Master | grep -o -m 1 "off")
length=$(($val/5))

bar=""
for i in $(seq 1 $length) ;
do
    bar="$bar━"
done

if [ "$status" == "off" ] || [ $val -eq 0 ] ; then
    dunstify -t 1000 -i /usr/share/icons/Adwaita/48x48/legacy/audio-volume-muted.png -h int:value:0 -h string:synchronous:volume ""
else dunstify -t 1000 -i /usr/share/icons/Adwaita/48x48/legacy/audio-volume-medium.png -h int:value:$vol -h string:synchronous:volume "  $bar"
fi
