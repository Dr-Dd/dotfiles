#!/bin/bash

get_current_workspace() {
	i3-msg -t get_workspaces \
		| grep -Po '(?<=name":")\w+(?=","visible":true,"focused":true)'
}

get_left_workspace() {
	curr_ws=$(get_current_workspace)
	if [[ $curr_ws -gt 1 ]] ; then 
		echo "$((curr_ws-1))"; 
	else 
		echo 1 
	fi 
}

get_right_workspace() {
	curr_ws=$(get_current_workspace)
	if [[ $curr_ws -lt 10 ]] ; then 
		echo "$((curr_ws+1))"; 
	else 
		echo 10 
	fi 
}

# Signature:
#	$1 = workspace
move_with_container() {
	i3-msg move container to workspace $1 
	i3-msg workspace $1 
}

error_message_and_exit() {
	echo "
Please specify one (1) of the following options:
	--left |-l			Step to workspace - 1
	--right|-r			Step to workspace + 1 
	--move-left|-ml			Move container to workspace - 1 
	--move-right|-mr		Move container to workspace + 1
	--get-current-workspace|-ws	Get currently focused workspace number
	--get-left-workspace|-lws	Get workspace number to the left of current
	--get-right-workspace|-rws	Get workspace number to the right of current"	
	exit 1
}

if [[ $# -eq 1 ]] ; then
	opt="$1";
	case "$opt" in
		"--left"|"-l" )
			i3-msg workspace $(get_left_workspace) > /dev/null 2>&1 ;;
		"--right"|"-r" )
			i3-msg workspace $(get_right_workspace) > /dev/null 2>&1 ;;
		"--move-left"|"-ml") 
			move_with_container $(get_left_workspace) > /dev/null 2>&1 ;;
		"--move-right"|"-mr") 
			move_with_container $(get_right_workspace) > /dev/null 2>&1 ;;
		"--get-current-workspace"|"-ws")
			echo $(get_current_workspace) ;;
		"--get-left-workspace"|"-lws")
			echo $(get_left_workspace) ;;
		"--get-right-workspace"|"-rws")
			echo $(get_right_workspace) ;;
		*)
			error_message_and_exit ;;
	esac
else 
	error_message_and_exit
fi
