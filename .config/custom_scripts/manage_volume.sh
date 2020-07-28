#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that handles volume of master channel and notify about it

# Common options
ACTION="$1"
PERCENTAGE="5%"
APPNAME="Volume"
APPICON_NAME="audio-volume-medium"
SUMMARY="Volume"
BODY="Current volume is: "

# Load Notify Script
SCRIPT_PATH=${0%/*}
source "$SCRIPT_PATH/notify.sh"

function get_volume_level {
    amixer get Master | grep 'Left' | awk '$0~/%/{print $5}' | tr -d '[]'
}

function check_if_is_mute {
    amixer get Master | grep off > /dev/null
}

function get_volume_icon_name {
    CURRENT_VOL=$(get_volume_level | cut -d'%' -f 1)
    if [[ $CURRENT_VOL -ge 11 ]] && [[ $CURRENT_VOL -le 30 ]]; then
        APPICON_NAME="audio-volume-low"
    elif [[ $CURRENT_VOL -ge 31 ]] && [[ $CURRENT_VOL -le 60 ]]; then
        APPICON_NAME="audio-volume-medium"
    elif [[ $CURRENT_VOL -ge 61 ]]; then
        APPICON_NAME="audio-volume-high"
    else
        APPICON_NAME="audio-volume-muted"
    fi
}

function manage_volume() {
    amixer set -q Master $1 > /dev/null
    get_volume_icon_name
    notify "$APPNAME" "$APPICON_NAME" "$SUMMARY" "$BODY $(get_volume_level)"
}

function toggle_mute {
    check_if_is_mute
    if [[ $? == 1 ]]
    then
        amixer -q set Master mute
        notify "$APPNAME" "audio-volume-muted" "$SUMMARY" "$BODY 0%"
    else
        amixer -q set Master unmute
        get_volume_icon_name
        notify "$APPNAME" "$APPICON_NAME" "$SUMMARY" "$BODY $(get_volume_level)"
    fi
}

if [[ -z $ACTION ]]
then
    echo "This script must have an action up/down/mute"
    exit 1
fi

if [[ $ACTION == "up" ]]
then
    manage_volume $PERCENTAGE"+"
elif [[ $ACTION == "down" ]]
then
    manage_volume $PERCENTAGE"-"
elif [[ $ACTION == "mute" ]]
then
    toggle_mute
fi

