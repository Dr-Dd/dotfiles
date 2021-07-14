#!/bin/bash

while true ; do
    rclone check ~/MEGA remote: --max-age 1d &> /dev/null
    if [ $? -eq 1 ]
    then dunstify -t 0 -i ~/.icons/Mega.png "MEGA" "It seems like your local and remote are out of sync, run action to manage the synchronization process" --action="urxvt -e ~/.scripts/rclone-megasync-sync.sh,Sync remote and local MEGA folder" | bash
    fi
    sleep 30m
done
