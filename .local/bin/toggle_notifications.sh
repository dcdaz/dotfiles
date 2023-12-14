#!/bin/sh

# Author : Daniel Cordova A.
# E-Mail : danesc87@gmail.com
# Github : @dcdaz
# Released under GPLv3

# Small script that enable/disable Dunst notifications and notify about the status

APPNAME="Notifications Toggler"
# Load Notify Script
SCRIPT_PATH=${0%/*}

STATUS=$(dunstctl is-paused)

if [ "$STATUS" == "true" ]; then
  python3 $SCRIPT_PATH/notify.py "$APPNAME" "stock_bell" "Notifications" "Notifications Enabled" 1
  dunstctl set-paused toggle
else
  python3 $SCRIPT_PATH/notify.py "$APPNAME" "stock_calc-cancel" "Notifications" "Notifications Disabled" 1
  sleep 1.5s && dunstctl set-paused toggle
fi

exit 0
