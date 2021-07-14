#!/bin/bash

red=$(tput setaf 1)
off=$(tput sgr0)

rclone check ~/MEGA remote: --one-way --max-age 1d # &> /dev/null
# Extra local files, remote is out of sync
if [ $? -eq 1 ]
then
    echo "${red}==>${off} It seems like your remote is out of sync"
    echo ""
    rclone sync ~/MEGA remote: --dry-run --max-age 1d
    echo "${red}==>${off} Are you sure you want to modify your remote like this?"
    hasChosen=false
    while [ "$hasChosen" = false ] ; do
        printf "${red}==>${off} [yes/no/Delete]: "
        read ans
        case "$ans" in
            yes) hasChosen=true && rclone sync ~/MEGA remote: -P --max-age 1d ;;
            no) hasChosen=true && echo "${red}==>${off} Aborting operation..." ;;
	    Delete) hasChosen=true && rclone sync remote: ~/MEGA -P --max-age 1d ;;
            *) echo "ERROR: Please select a valid option" ;;
        esac
    done
fi

echo ""
rclone check remote: ~/MEGA --one-way --max-age 1d # &> /dev/null
# Extra remote files, local is out of sync
if [ $? -eq 1 ]
then
    echo "${red}==>${off} It seems like your Local is out of sync"
    echo ""
    rclone sync remote: ~/MEGA --dry-run --max-age 1d
    echo "${red}==>${off} Are you sure you want to modify your Local like this?"
    hasChosen=false
    while [ "$hasChosen" = false ] ; do
        printf "${red}==>${off} [yes/no/Delete]: "
        read ans
        case "$ans" in
            yes) hasChosen=true && rclone sync remote: ~/MEGA -P --max-age 1d ;;
            no) hasChosen=true && echo "${red}==>${off} Aborting operation" ;;
	    Delete) hasChosen=true && rclone sync ~/MEGA remote: -P --max-age 1d;;
            *) echo "ERROR: Please select a valid option"
        esac
    done
fi
