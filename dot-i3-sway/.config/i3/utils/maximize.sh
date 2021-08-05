#!/bin/sh

get_current_workspace() {
	i3-msg -t get_workspaces \
		| grep -Po '(?<=name":")\w+(?=","visible":true,"focused":true)'
}

if [[ $(get_current_workspace) = "M" ]] ; then
	i3-msg move window to workspace back_and_forth, workspace back_and_forth
else
	i3-msg move window to workspace "M", workspace "M"
fi
