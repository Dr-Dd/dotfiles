#!/bin/bash
length=$(($(xbacklight -get | awk -F "." '{print $1}')/5))
bar=""
for i in $(seq 1 $length) ;
do
    bar="$bar━"
done

dunstify -t 1000 -i /usr/share/icons/Adwaita/48x48/legacy/weather-clear.png -h int:value:$vol -h string:synchronous:volume "  $bar"

