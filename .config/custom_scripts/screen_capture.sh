#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Zenity script to allow capture screen with dirrefent options
# Selected area, Whole Screen, Whole Screen with pointer, Focused Window

# Common options
TEMPLATE="Screenshot_%Y-%m-%d_%H-%M-%S.png"
SCROT_PATH="$HOME/Pictures/"

# Zenity options
CAPTURE_TITLE='Screen capture'
CAPTURE_MESSAGE='Select capture type'
REACTANGULAR_AREA='Rectangular Area'
WHOLE_SCREEN='Whole Screen'
WHOLE_SCREEN_WITH_POINTER='Whole Screen with pointer'
FOCUSED_WINDOW='Focused window'

# Process options
ZENITY_PROCESS=$(ps aux | grep -i zenity)
CAPTURE_PROCESS_STRING="zenity --class=screen-capture --name=screen-capture"
CAPTURE_RUNNING=$(echo "$ZENITY_PROCESS" | grep -E "$CAPTURE_PROCESS_STRING")

if [[ -z "$CAPTURE_RUNNING" ]]; then

    set -x
    CAPTURE_TYPE=$(\
        zenity --class=screen-capture --name=screen-capture --title="$CAPTURE_TITLE" \
        --list --text="$CAPTURE_MESSAGE" \
        --radiolist --column=Select --column=Option \
        TRUE "$REACTANGULAR_AREA" \
        FALSE "$WHOLE_SCREEN" \
        FALSE "$WHOLE_SCREEN_WITH_POINTER" \
        FALSE "$FOCUSED_WINDOW" \
        --hide-header\
    )
    set +x

    case $CAPTURE_TYPE in 
        $REACTANGULAR_AREA)
            scrot -l style=solid,width=1,color="#2f343f" -s $TEMPLATE -e 'mv $f '$SCROT_PATH
            ;;
        $WHOLE_SCREEN)
           scrot -d 1 $TEMPLATE -e 'mv $f '$SCROT_PATH
            ;;
        $WHOLE_SCREEN_WITH_POINTER)
            scrot -d 1 -p $TEMPLATE -e 'mv $f '$SCROT_PATH
            ;;
        $FOCUSED_WINDOW)
            scrot -d 1 -u $TEMPLATE -e 'mv $f '$SCROT_PATH
            ;;
    esac

    if [[ ! -z "$CAPTURE_TYPE" ]]; then
        # Load Notify Script
        SCRIPT_PATH=${0%/*}
        source "$SCRIPT_PATH/notify.sh"
        # Notify screen capture
        notify "Screen Capture" "applets-screenshooter" "Screen Capture" "Screen captured succesfully on: \"$SCROT_PATH\""
    fi
fi
