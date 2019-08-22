#!/bin/bash

if [ ps -o state= -p $(pgrep xautolock) = T ] ; then
    # This is to restore xautolock
    kill -CONT $(pgrep xautolock) && echo "xautolock has been restored"
else
    # This is to pause xautolock
    kill -STOP $(pgrep xautolock) && echo "xautolock has been paused" 
fi
