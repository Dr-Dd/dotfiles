#!/bin/bash

pacman -Qu # generate status code
if [ $? -ne 1 ] ; then
  echo 'UPDATE AVAILABLE'
else
  echo 'up to date'
fi
