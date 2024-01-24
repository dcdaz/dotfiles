#!/bin/sh

# Author : Daniel Cordova
# E-Mail : danesc87@gmail.com
# Github : @dcdaz

# Script that gets current desktop echoes it and or allow to change between desktops

ACTION="$1"
ICON_THEME="Papirus-Dark"
ICON_PATH="/usr/share/icons/"
ACTION_PATH="/16x16/panel/"

function get_current_desktop_name {
    wmctrl -d | grep '*' | cut -d ' ' -f 14-20
}

function get_current_desktop_id {
    wmctrl -d | grep '*' | cut -d ' ' -f 1
}

function move_to_desktop {
  current_desktop=$(get_current_desktop_id)
  if [ "$1" == "next" ]; then
    desktop_amount=$(($(wmctrl -d | wc -l) -1))
    if [ $current_desktop == $desktop_amount ]; then
      wmctrl -s 0
      exit 0
    fi
    next_desktop=$(($(get_current_desktop_id) + 1))
    wmctrl -s $next_desktop
    exit 0
  fi
  
  if [ "$1" == "prev" ]; then
    if [ $current_desktop -eq 0 ]; then
      desktop_amount=$(($(wmctrl -d | wc -l) -1))
      wmctrl -s $desktop_amount
      exit 0
    fi
    prev_desktop=$(($(get_current_desktop_id) - 1))
    wmctrl -s $prev_desktop
    exit 0
  fi
}

if [ -z $ACTION ]; then
    echo $ICON_PATH$ICON_THEME$ACTION_PATH"indicator-workspaces-"$(get_current_desktop_name).svg
    exit 0
fi

if [ $ACTION == "next" ]; then
    move_to_desktop $ACTION
elif [ $ACTION == "prev" ]; then
    move_to_desktop $ACTION
else 
    echo "This script accepts next/prev or empty args"
    exit 1
fi

exit 0
