#!/bin/bash

pgrep cantata
if [ $? -ne 1 ] ; then
    mpc toggle
fi
