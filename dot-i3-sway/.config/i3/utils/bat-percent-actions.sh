#!/bin/bash

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
_regexp=

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
	_regexp='[[:digit:]]+'
	[[ $1 =~ $_regexp ]] && _percent=${BASH_REMATCH[0]}
	if [ -z "$_percent" ] ; then
		self_kill "ERROR: missing percentage"
	fi
	_regexp="(>|>=|<|<=|=)"
	[[ $1 =~ $_regexp ]] && _comparator=${BASH_REMATCH[0]}
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
				_regexp="[smhd]"
				[[ $2 =~ $_regexp ]] && _suffix=${BASH_REMATCH[0]}
				if [ -z "$_suffix" ] ; then
					self_kill 'ERROR: invalid interval unit provided.'
				fi
				_regexp="^[[:digit:]]*"
				[[ $2 =~ $_regexp ]] && _prefix=${BASH_REMATCH[0]}
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
	_bat_amp=`cat /sys/class/power_supply/BAT0/charge_now`
	_bat_amp_full=`cat /sys/class/power_supply/BAT0/charge_full`
	_curr_perc=`printf %.0f "$((100 * $_bat_amp / $_bat_amp_full))"`
	_ac_state=`cat /sys/class/power_supply/BAT0/status`
	if [ "$_ac_state" = "Charging" ] ; then
		for i in "${!_ac_action_map[@]}"
		do
			exec_action "$i" "${_ac_action_map[$i]}" "$_curr_perc"
		done
	elif [ "$_ac_state" = "Discharging" ] ; then
		for i in "${!_battery_action_map[@]}"
		do
			exec_action "$i" "${_battery_action_map[$i]}" "$_curr_perc"
		done
	fi
	sleep "$_interval"
done
