#!/bin/bash

if [[ -z "$@" ]]
then
    cat $HOME/.locate-textdb.out
else
    coproc ( xdg-open "$@" > /dev/null 2>&1 )
    exec 1>&-
    exit;
fi
