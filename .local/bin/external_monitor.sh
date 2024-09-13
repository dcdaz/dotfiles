#!/bin/sh

# Author : Daniel Cordova
# E-Mail : danesc87@gmail.com
# Github : @dcdaz

# Script that check if an external monitor is connected
# put external monitor as primary and deactivate laptop monitor

# Monitor connections
VGA="VGA"
eDP="eDP"
DP="DP"
HDMI="HDMI"
LVDS="LVDS"

# Status
CONNECTED_STATUS="connected"

# Get Connection type and current status
CONNECTION=$(xrandr | grep -vE "$eDP|$LVDS" | grep -E "$VGA|$DP|$HDMI" | grep -w $CONNECTED_STATUS)
EXTERNAL_OUTPUT_IS_CONNECTED=$(echo "$CONNECTION" |cut -d ' ' -f 2)

# Find Internal output
INTERNAL_OUTPUT=$(xrandr |grep -E "$eDP|$LVDS" | cut -d ' ' -f 1)

# Change from external to internal and vice versa when external output is connected/disconnected
# NOTE: Rate and resolution are made for my Laptop and my Monitor, so you need to change them
if [ "$EXTERNAL_OUTPUT_IS_CONNECTED" == "$CONNECTED_STATUS" ]; then
  # Find External output
  EXTERNAL_OUTPUT=$(echo "$CONNECTION" | cut -d ' ' -f 1)
  xrandr --output $EXTERNAL_OUTPUT --primary --mode 2560x1080 --rate 74.99 --output $INTERNAL_OUTPUT --off
else
  # Check if Internal ouput is active after disconnect External output
  IS_INTERNAL_ACTIVE=$(xrandr | grep -E "$eDP|$LVDS" -A 1 | grep '*')
  if [ -z "$IS_INTERNAL_ACTIVE" ]; then
    xrandr --output $INTERNAL_OUTPUT --primary --mode 1920x1080 --rate 240.00
  fi
fi

exit 0
