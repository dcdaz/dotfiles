#!/bin/sh

# Author : Daniel Cordova A.
# E-Mail : danesc87@gmail.com
# Github : @dcdaz
# Released under GPLv3

# Simple script that locks screen with i3lock or enables i3lock via xautlock

# Common options
ACTION="$1"

if [ -z $ACTION ]; then
    echo "This script must have an action lock/autolock"
    exit 1
fi

if [ $ACTION == "lock" ]; then
  i3lock -neu -p default -i ~/Pictures/hackers/hacker-desk3.png &
elif [ $ACTION == "autolock" ]; then
  xautolock -time 5 -locker "i3lock -neu -p default -i ~/Pictures/hackers/hacker-desk3.png" -detectsleep -killtime 60 -killer "systemctl suspend" &
fi

exit 0
