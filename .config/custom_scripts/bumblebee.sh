#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that gets info of NVIDIA card on a Zenity info window

# Common options
ACTION="$1"
BUMBLE_TITLE='Bumblebee Info'
SCRIPT_PATH=${0%/*}
source "$SCRIPT_PATH/nvidia.sh"
NVIDIA_QUERY=$(get_nvidia_data -q)
NVIDIA_DATA=''

function get_nvidia_active {
    CURRENT_TEMPERATURE=$(echo "$NVIDIA_QUERY" | grep "GPU Current Temp" | cut -d ':' -f 2 | cut -d ' ' -f 2)
    if [[ ! -z "$CURRENT_TEMPERATURE" ]]; then
        echo ""
    else
        echo ""
    fi
}


function get_full_nvidia_info {
    # Zenity Options
    ZENITY_PROCESS=$(ps aux | grep -i zenity)
    BUMBLEBEE_PROCESS_STRING="zenity --class=bumblebee-info --name=bumblebee-info"
    BUMBLEBEE_RUNNING=$(echo "$ZENITY_PROCESS" | grep -E "$BUMBLEBEE_PROCESS_STRING")

    if [[ -z "$BUMBLEBEE_RUNNING" ]]; then
        FAILED=$(echo "$NVIDIA_QUERY" | grep 'NVIDIA-SMI has failed')
        if [[ -z $FAILED ]]; then
            get_data
            exec zenity --class=bumblebee-info --name=bumblebee-info --title="$BUMBLE_TITLE" \
                --info --icon-name=bumblebee --no-wrap --ellipsize --text="$NVIDIA_DATA"
        fi
    else
        NVIDIA_DATA=''
        kill -9 $(echo "$BUMBLEBEE_RUNNING" | awk '{print $2}')
    fi
}

function get_data {
    NVIDIA_CARD_NAME=$(echo "$NVIDIA_QUERY" | grep "Product Name" | cut -d ':' -f 2 | cut -d ' ' -f 2)
    NVIDIA_DRIVER=$(echo "$NVIDIA_QUERY" | grep "Driver Version" | cut -d ':' -f 2 | cut -d ' ' -f 2)
    NVIDIA_TOTAL_MEMORY=$(echo "$NVIDIA_QUERY" | grep -e 'FB Memory Usage' -A 3 | grep 'Total' | cut -c9-)
    NVIDIA_USED_MEMORY=$(echo "$NVIDIA_QUERY" | grep -e 'FB Memory Usage' -A 3 | grep 'Used' | cut -c9-)
    NVIDIA_FREE_MEMORY=$(echo "$NVIDIA_QUERY" | grep -e 'FB Memory Usage' -A 3 | grep 'Free' | cut -c9-)
    CURRENT_TEMPERATURE=$(echo "$NVIDIA_QUERY" | grep "GPU Current Temp" | cut -d ':' -f 2 | cut -d ' ' -f 2)
    NVIDIA_DATA="\
        Card Name:\t\t$NVIDIA_CARD_NAME\n\
        Driver:\t\t\t$NVIDIA_DRIVER\n\
        Temperature:\t$CURRENT_TEMPERATURE°C\n\
        Memory:\n\
        \t   $NVIDIA_TOTAL_MEMORY\n\
        \t   $NVIDIA_USED_MEMORY\n\
        \t   $NVIDIA_FREE_MEMORY\
    "
}


if [[ -z $ACTION ]]; then
    echo "This script must have an action TEMP/FULL"
    exit 1
fi

if [[ $ACTION == "ACT" ]]; then
    get_nvidia_active
elif [[ $ACTION == "FULL" ]]; then
    get_full_nvidia_info
fi

