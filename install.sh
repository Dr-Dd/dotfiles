#!/bin/sh

PKG_MNG=""
PKG_MNG_OPTS=""

pacman --version > /dev/null 2>&1 
if [ $? -ne 127 ] 
then
	PKG_MNG="pacman"
fi



