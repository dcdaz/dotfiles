#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

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
CONNECTION=$(xrandr | grep -v "$eDP" | grep -E "$VGA|$DP|$HDMI" | grep -w $CONNECTED_STATUS)
EXTERNAL_OUTPUT_IS_CONNECTED=$(echo "$CONNECTION" |cut -d ' ' -f 2)

# Find External and Internal output
EXTERNAL_OUTPUT=$(echo "$CONNECTION" | cut -d ' ' -f 1)
INTERNAL_OUTPUT=$(xrandr |grep "$LVDS\|$eDP" | cut -d ' ' -f 1)

# Change from external to internal and vice versa when external output is connected/disconnected
if [ "$EXTERNAL_OUTPUT_IS_CONNECTED" == "$CONNECTED_STATUS" ]; then
    xrandr --output $EXTERNAL_OUTPUT --primary --auto --output $INTERNAL_OUTPUT --off
else
    xrandr --output $INTERNAL_OUTPUT --primary --auto --output $EXTERNAL_OUTPUT --off
fi

exit 0
