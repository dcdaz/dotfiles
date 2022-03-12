#!/bin/sh

# Author : Daniel Cordova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that handles laptop keyboard backlight and notify about it

# Common options
ACTION="$1"
APPNAME="Keyboard Backlight"
APPICON="keyboard"
SUMMARY="Keyboard Backlight"
BODY="Current backlight"
# Since this search son asus::kbd_backlight will work just on Asus laptops
# you need to change with your own backlight path, only teste on Asus ROG Zephyrus M15
CURRENT_BACKLIGHT=$(cat /sys/class/leds/asus::kbd_backlight/brightness)
BACKLIGHT_TEXT=""

# Load Notify Script
SCRIPT_PATH=${0%/*}

function get_current_backlight() {
    if [ "$1" -le 0 ]; then
      echo "off"
    elif [ "$1" == 1 ]; then
      echo "low"
    elif [ "$1" == 2 ]; then
      echo "medium"
    else
      echo "high"
    fi
}

function raise_backlight() {
    BACKLIGHT=$(($CURRENT_BACKLIGHT + 1))
    if [ $BACKLIGHT -gt 3 ]; then
      python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight $BACKLIGHT)" 1
      exit 0
    fi
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$BACKLIGHT
    python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight $BACKLIGHT)" 1
}

function lower_backlight() {
    BACKLIGHT=$(($CURRENT_BACKLIGHT - 1))
    if [ $BACKLIGHT -lt 0 ]; then
      python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight $BACKLIGHT)" 1
      exit 0
    fi
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$BACKLIGHT
    python3 $SCRIPT_PATH/notify.py "$APPNAME" "$APPICON" "$SUMMARY" "$BODY $(get_current_backlight $BACKLIGHT)" 1
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
