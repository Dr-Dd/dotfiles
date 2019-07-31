#!/bin/bash

function getVolume {
  amixer sget Master | grep -o -m 1 "[0-9]*%"
}

function isMute {
  speakerStatus=$((amixer sget Master | egrep -o -m 1 "\[(on)|(off)") | grep -o -m 1 "[a-z]*")
  #echo $speakerStatus
  if [ $speakerStatus == "on" ]; then
    false
  else
    true
  fi
}

function volumeBar {
  bar="["
  volume=$(getVolume)
  blockNum="$(getVolume | egrep -o -m 1 "^.")"
  if [ $volume == "5%" ]; then
    blockNum="1"
  else 
    if [ $volume == "100%" ]; then
      blockNum="10"
    fi
  fi
  #echo $blockNum
  #echo $volume
  for i in {1..10}
  do
    if [ $i -le $blockNum ]; then
      bar="${bar}◼"
    else
      bar="${bar}◻" 
    fi
  done
  bar="${bar}] $volume"
  /home/drd/dunst/dunstify -i audio-volume-high -r "$mn" "$bar"
}

mn="991049"

if isMute; then
  /home/drd/dunst/dunstify -u low -i audio-volume-muted -r "$mn" "[◻◻◻◻◻◻◻◻◻◻] muted"
else
  volumeBar
fi
