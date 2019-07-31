#!/bin/bash

  bar="["
  backlightVal=$(xbacklight -get | awk 'BEGIN { FS = "." }; { print $1 }' ) 
  blockNum="$(echo $backlightVal | egrep -o -m 1 "^.")"
  if [ $backlightVal == "100" ]; then
    blockNum="10"
  else
    if [ $backlightVal -le "10" ]; then
      blockNum="1"
    fi
  fi
  for i in {1..10}
  do
    if [ $i -le $blockNum ]; then
      bar="${bar}◼"
    else
      bar="${bar}◻"
    fi
  done
  bar="${bar}] $backlightVal%" 

  mn="991049"

  /home/drd/dunst/dunstify -i weather-clear -r "$mn" "$bar"
