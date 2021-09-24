#!/bin/sh

get_current_workspace() {
	i3-msg -t get_workspaces \
		| grep --perl-regexp --only-matching \
		'(?<=name":")\w+(?=","visible":true,"focused":true)'
}

_ws_num=`echo $(get_current_workspace) | grep -Eo '[[:digit:]]+'`
_ws_max=`echo $(get_current_workspace) | grep -Eo 'M'`

if [ -z "$_ws_max" ] ; then
	_ws_dest="M${_ws_num}"
else
	_ws_dest="$_ws_num"
fi

i3-msg move window to workspace "$_ws_dest", workspace "$_ws_dest"

