#!/bin/sh

# TODO: remove repeated code snippets.
#	right now i didn't since creating a function that accepts a map as
#	argument in bash is terribly unclean, so unclean that it's more
#	easily readable to have long portions of code repeated.

# AKA Suicide
self_kill() {
	printf '%s\n' "$1" >&2
	exit 1
}

# Initialize vars
_percent=
_comparator=
_action=
declare -A _battery_action_map
declare -A _ac_action_map
_interval=
_suffix=
_prefix=
_curr_perc=

# $1 -> action string
action_str_to_vars () {
	_percent="${1%%,*}"
	if [ -z "$_percent" ] ; then
		self_kill "ERROR: Invalid percentage provided."
	fi
	_action="${1#*,}"
	if [ -z "$_action" ] ; then
		self_kill "ERROR: Invalid action provided."
	fi
}

# $1 -> percentage with comparator
# $2 -> action
# $3 -> current percentage
exec_action() {
	# Strip correct stuff
	_percent=`echo $1 | grep -Eo "[[:digit:]]*"`
	if [ -z "$_percent" ] ; then
		self_kill "ERROR: missing percentage"
	fi
	_comparator=`echo $1 | grep -Eo "(>|>=|<|<=|=)"`
	if [ -z "$_comparator" ] ; then
		self_kill "ERROR: missing comparator operator"
	fi
	# Run comparator command
	if [ "$_comparator" = ">" ] && [ "$3" -gt "$_percent" ] ; then
		sh -c "$2"
	elif [ "$_comparator" = ">=" ] && [ "$3" -ge "$_percent" ] ; then
		sh -c "$2"
	elif [ "$_comparator" = "<" ] && [ "$3" -lt "$_percent" ] ; then
		sh -c "$2"
	elif [ "$_comparator" = "<=" ] && [ "$3" -le "$_percent" ] ; then
		sh -c "$2"
	elif [ "$_comparator" = "=" ] && [ "$3" -eq "$_percent" ] ; then
		sh -c "$2"
	fi
}

# Parse opts
while :
do
	case $1 in
		-ba|--battery-action)
			if [ "$2" ] ; then
				action_str_to_vars "$2"
				_battery_action_map[$_percent]="$_action"
				shift
			else
				self_kill 'ERROR: invalid "--battery-action" provided.'
			fi
			;;
		-ac|--ac-action)
			if [ "$2" ] ; then
				action_str_to_vars "$2"
				_ac_action_map[$_percent]="$_action"
				shift
			else
				self_kill 'ERROR: invalid "--ac-action" provided.'
			fi
			;;
		-i|--interval)
			if [ "$2" ]; then
				_interval="$2"
				_suffix=`echo "$2" | sed "s/^[[:digit:]]*//"`
				if [ -n "$_suffix" ] ; then
					echo $_suffix | grep -Eo "^(s|m|h|d)$" > /dev/null 2>&1
					if [ $? -eq 1 ] ; then
						self_kill 'ERROR: invalid interval unit provided.'
					fi
				fi
				_prefix=`echo "$2" | grep -Eo "^[[:digit:]]*"`
				if [ -z "$_prefix" ] ; then
					self_kill 'ERROR: invalid "--interval" provided.'
				fi
				shift
			else
				self_kill 'ERROR: invalid "--interval" provided.'
			fi
			;;
		*)
			break
			;;
	esac
	shift
done

if [ -z "$_interval" ]; then
	_interval="5m"
fi

# Main loop
while :
do
	# Refresh bat percentage
	_curr_perc=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
		| grep percentage \
		| grep -Eo "[[:digit:]]{,3}"`
	_ac_state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
		| grep state \
		| grep -Eo "(charging|discharging)"`
	if [ "$_ac_state" = "charging" ] ; then
		for i in "${!_ac_action_map[@]}"
		do
			exec_action "$i" "${_ac_action_map[$i]}" "$_curr_perc"
		done
	elif [ "$_ac_state" = "discharging" ] ; then
		for i in "${!_battery_action_map[@]}"
		do
			exec_action "$i" "${_battery_action_map[$i]}" "$_curr_perc"
		done
	fi
	sleep "$_interval"
done
