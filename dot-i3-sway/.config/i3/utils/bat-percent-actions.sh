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
_battery_action=
_ac_action=
declare -A _battery_action_map
declare -A _ac_action_map
_interval=
_suffix=
_prefix=
_curr_perc=

# Parse opts
while :
do
	case $1 in
		-ba|--battery-action)
			if [ "$2" ] ; then
				_percent="${2%%,*}"
				if [ -z "$_percent" ] ; then
					self_kill "ERROR: Invalid percentage provided."
				fi
				_battery_action="${2#*,}"
				if [ -z "$_battery_action" ] ; then
					self_kill "ERROR: Invalid action provided."
				fi
				_battery_action_map[$_percent]="$_battery_action"
				shift
			else
				self_kill 'ERROR: invalid "--battery-action" provided.'
			fi
			;;
		-ac|--ac-action)
			if [ "$2" ] ; then
				_percent="${2%%,*}"
				if [ -z "$_percent" ] ; then
					self_kill "ERROR: Invalid percentage provided."
				fi
				_ac_action="${2#*,}"
				if [ -z "$_ac_action" ] ; then
					self_kill "ERROR: Invalid action provided."
				fi
				_ac_action_map[$_percent]="$_ac_action"
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
	_curr_perc=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -Eo "[[:digit:]]{,3}"`
	_ac_state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | grep -Eo "(charging|discharging)"`
	if [ "$_ac_state" = "charging" ] ; then
		for i in "${!_ac_action_map[@]}"
		do
			# Strip correct stuff
			_percent=`echo $i | grep -Eo "[[:digit:]]*"`
			if [ -z "$_percent" ] ; then
				self_kill "ERROR: missing percentage"
			fi
			_comparator=`echo $i | grep -Eo "(>|>=|<|<=|=)"`
			if [ -z "$_comparator" ] ; then
				self_kill "ERROR: missing comparator operator"
			fi
			# Run comparator command	
			if [ "$_comparator" = ">" ] && [ "$_curr_perc" -gt "$_percent" ] ; then
				sh -c "${_ac_action_map[$i]}"
			elif [ "$_comparator" = ">=" ] && [ "$_curr_perc" -ge "$_percent" ] ; then
				sh -c "${_ac_action_map[$i]}"
			elif [ "$_comparator" = "<" ] && [ "$_curr_perc" -lt "$_percent" ] ; then
				sh -c "${_ac_action_map[$i]}"
			elif [ "$_comparator" = "<=" ] && [ "$_curr_perc" -le "$_percent" ] ; then
				sh -c "${_ac_action_map[$i]}"
			elif [ "$_comparator" = "=" ] && [ "$_curr_perc" -eq "$_percent" ] ; then
				sh -c "${_ac_action_map[$i]}"
			fi
		done
	elif [ "$_ac_state" = "discharging" ] ; then
		for i in "${!_battery_action_map[@]}"
		do
			# Strip correct stuff
			_percent=`echo $i | grep -Eo "[[:digit:]]*"`
			if [ -z "$_percent" ] ; then
				self_kill "ERROR: missing percentage"
			fi
			_comparator=`echo $i | grep -Eo "(>|>=|<|<=|=)"`
			if [ -z "$_comparator" ] ; then
				self_kill "ERROR: missing comparator operator"
			fi
			# Run comparator command	
			if [ "$_comparator" = ">" ] && [ "$_curr_perc" -gt "$_percent" ] ; then
				sh -c "${_battery_action_map[$i]}"
			elif [ "$_comparator" = ">=" ] && [ "$_curr_perc" -ge "$_percent" ] ; then
				sh -c "${_battery_action_map[$i]}"
			elif [ "$_comparator" = "<" ] && [ "$_curr_perc" -lt "$_percent" ] ; then
				sh -c "${_battery_action_map[$i]}"
			elif [ "$_comparator" = "<=" ] && [ "$_curr_perc" -le "$_percent" ] ; then
				sh -c "${_battery_action_map[$i]}"
			elif [ "$_comparator" = "=" ] && [ "$_curr_perc" -eq "$_percent" ] ; then
				sh -c "${_battery_action_map[$i]}"
			fi
		done
	fi
	sleep "$_interval"
done
