#!/bin/sh

background="$HOME/.wallpaper/$(ls $HOME/.wallpaper | shuf -n 1)"
cp $background /usr/share/backgrounds/background.img
