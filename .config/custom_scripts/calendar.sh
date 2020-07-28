#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script to execute python calendar when user clicks on date section of tint2

SCRIPT_PATH=${0%/*}
CALENDAR_NAME="calendar.py"
CALENDAR_RUNNING=$(ps aux | grep -i "$CALENDAR_NAME" | grep -E 'python3')

echo "$CALENDAR_RUNNING"

if [[ -z "$CALENDAR_RUNNING" ]]; then
    exec python3 "$SCRIPT_PATH/$CALENDAR_NAME" > /dev/null &
else
    kill -9 $(echo "$CALENDAR_RUNNING" | awk '{print $2}')
fi

