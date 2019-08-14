#!/bin/bash

pacman -Qu > /dev/null 2>&1 # generate status code
if [ $? -ne 1 ] ; then
  echo 'UPDATE(s) AVAILABLE'
else
  echo 'up to date'
fi
