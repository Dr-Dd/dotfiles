#!/bin/bash


if [[ -z "$1" ]]; then
	bash_words=$(compgen -k | tr '\n' ' ')
	bash_words+=" $(compgen -b | tr '\n' ' ')"
	all_words=$(compgen -c | tr '\n' ' ')

	all_words=`echo ${all_words} | grep -v "${bash_words}"`

	echo $all_words | sort -u
else
	coproc ( prime-run "$@" > /dev/null 2>&1 )
	exec 1>&-
	exit;
fi
