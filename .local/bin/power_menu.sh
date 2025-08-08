#!/bin/sh

# Author : Daniel Cordova
# E-Mail : danesc87@gmail.com
# Github : @dcdaz

# Small script that shows a Rofi theme for having a power menu
# and then execute the option user selected


UPTIME=$(uptime | awk '{print $3}' | cut -d ',' -f 1)
HOUR=$(echo "$UPTIME" | cut -d ':' -f 1)
MINUTE=$(echo "$UPTIME" | cut -d ':' -f 2)

function get_uptime_str {
    HOUR_STR=""
    MINUTE_STR=""
    if [ "$HOUR" == "1" ]; then
      HOUR_STR="$HOUR hour"
    else
      HOUR_STR="$HOUR hours"
    fi

    if [ "$MINUTE" == "1" ]; then
      MINUTE_STR="$MINUTE minute"
    else
      MINUTE_STR="$MINUTE minutes"
    fi
    echo "$HOUR_STR, $MINUTE_STR"
}

# Options
# Uses Nerd Fonts
EXIT="󰿅"
SUSPEND="󰍷"
SHUTDOWN="⏻"
REBOOT=""
HIBERNATE=""

CHOSEN=$(\
          echo -e "$SUSPEND\n$HIBERNATE\n$SHUTDOWN\n$REBOOT\n$EXIT" |\
          rofi -theme ~/.config/rofi/power_menu.rasi -p\
          "Uptime: $(get_uptime_str)" \
          -dmenu -selected-row $1\
)

case $CHOSEN in
  $SUSPEND)
    systemctl suspend
    ;;
  $HIBERNATE)
    systemctl hibernate
    ;;
  $SHUTDOWN)
    systemctl poweroff
    ;;
  $REBOOT)
    systemctl reboot
    ;;
  $EXIT)
    openbox --exit
    ;;
esac
exit 0
