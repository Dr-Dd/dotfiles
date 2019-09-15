#!/bin/bash

pgrep cantata
if [ $? -ne 1 ] ; then
    mpc next
fi
