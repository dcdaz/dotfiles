#!/bin/sh

# Author : Daniel Córdova A.
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
source "$SCRIPT_PATH/notify.sh"

function get_current_backlight() {
    xbacklight -get
}

function raise_backlight() {
    xbacklight +$VALUE
    notify "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight)"
}

function lower_backlight() {
    xbacklight -$VALUE
    notify "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight)"
}

if [[ -z $ACTION ]]
then
    echo "This script must have an action up/down"
    exit 1
fi

if [[ $ACTION == "up" ]]
then
    raise_backlight
elif [[ $ACTION == "down" ]]
then
    lower_backlight
fi

