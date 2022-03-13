#!/bin/sh

# Author : Daniel Cordova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that gets current volume level and echoes an icon
# Icon theme, path, and action (mening size and place of icons) should be change to your own

ICON_THEME="Papirus-Dark"
ICON_PATH="/usr/share/icons/"
ACTION_PATH="/16x16/actions/"
APPICON_NAME="audio-volume-medium.svg"

function get_volume_level {
    amixer get Master | grep 'Left' | awk '$0~/%/{print $5}' | tr -d '[]'
}

function get_volume_icon_name {
    CURRENT_VOL=$(get_volume_level | cut -d'%' -f 1)
    if [ $CURRENT_VOL -ge 11 ] && [ $CURRENT_VOL -le 30 ]; then
        APPICON_NAME="audio-volume-low.svg"
    elif [ $CURRENT_VOL -ge 31 ] && [ $CURRENT_VOL -le 60 ]; then
        APPICON_NAME="audio-volume-medium.svg"
    elif [ $CURRENT_VOL -ge 61 ]; then
        APPICON_NAME="audio-volume-high.svg"
    else
        APPICON_NAME="audio-volume-muted.svg"
    fi
}


get_volume_icon_name

echo $ICON_PATH$ICON_THEME$ACTION_PATH$APPICON_NAME

exit 0
