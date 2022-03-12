#!/bin/sh

# Author : Daniel Cordova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that handles laptop brightness and notify about it

# Common options
ACTION="$1"
VALUE="10"
APPNAME="Brightness"
APPICON="display-brightness"
SUMMARY="Brightness"
BODY="Current brightness"

# Load Notify Script
SCRIPT_PATH=${0%/*}

function get_current_backlight() {
    xbacklight -get
}

function raise_backlight() {
    xbacklight +$VALUE
    python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight)" 1
}

function lower_backlight() {
    xbacklight -$VALUE
    python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight)" 1
}

if [ -z $ACTION ]; then
    echo "This script must have an action up/down"
    exit 1
fi

if [ $ACTION == "up" ]; then
    raise_backlight
elif [ $ACTION == "down" ]; then
    lower_backlight
fi

exit 0
