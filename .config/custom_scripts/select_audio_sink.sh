#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Zenity script to have options to change default sink source and current sink input
# Sink Source -> Available Audio Card for ouput
# Sink Input -> App that uses some card

# Zenity options
AUDIO_SINK_TITLE='Output Audio'
AUDIO_SINK_MESSAGE='Select audio sink'
DEFAULT_SINK_SOURCE=$(pacmd list-sinks | grep -e '* index:' -e 'alsa.card_name' | sed -n '/*/{N; p}' | grep 'alsa' | cut -d '"' -f 2)
SINK_SOURCE_ZENITY_LIST=()

# Process options
ZENITY_PROCESS=$(ps aux | grep -i zenity)
AUDIO_SINK_PROCESS_STRING="zenity --class=select-audio-sink --name=select-audio-sink"
AUDIO_SINK_RUNNING=$(echo "$ZENITY_PROCESS" | grep -E "$AUDIO_SINK_PROCESS_STRING")

if [[ -z "$AUDIO_SINK_RUNNING" ]]; then

    SINK_SOURCE_ZENITY_LIST=("${SINK_SOURCE_ZENITY_LIST[@]}")
    # We need to change IFS to allow Array of string with spaces
    OIFS=$IFS
    IFS=$(echo -en "\n\b")
    # All sink source names except default
    SINK_SOURCE_LIST=($(pacmd list-sinks | grep 'alsa.card_name' | cut -d '"' -f 2 | grep -v "$DEFAULT_SINK_SOURCE" | sed -e "s/.*/\"&\"/"))
    for SINK_SOURCE in "${SINK_SOURCE_LIST[@]}"; do
        SINK_SOURCE_ZENITY_LIST=("${SINK_SOURCE_ZENITY_LIST[@]}" "FALSE" "$SINK_SOURCE")
    done
    IFS=$OIFS

    AUDIO_SINK_TYPE=$(\
        zenity --class=select-audio-sink --name=select-audio-sink --title="$AUDIO_SINK_TITLE" \
        --list --text="$AUDIO_SINK_MESSAGE" \
        --radiolist --column=Select --column=Sink \
        TRUE "$DEFAULT_SINK_SOURCE" \
        "${SINK_SOURCE_ZENITY_LIST[@]}"\
        --hide-header\
    )
    
    if [[ ! -z "$AUDIO_SINK_TYPE" ]]; then
        SELECTED_SINK_INDEX=$(pacmd list-sinks | grep -e 'alsa.card_name' -e 'index:' | grep "$AUDIO_SINK_TYPE" -B 1 | grep 'index:' | cut -d ':' -f 2 | cut -d ' ' -f 2)
        # Change default Sink source
        pacmd set-default-sink $SELECTED_SINK_INDEX
        # Change sink input -> current sound to a different card
        # This should be a for, due to several active sink inputs and needs a control qhen no inputs
        SINK_INPUT_LIST=($(pacmd list-sink-inputs | grep 'index:' | cut -d ':' -f 2 | cut -d ' ' -f 2))
        CURRENT_SINK_NAME=$(pacmd list-sinks | grep -e '* index:' -e 'name:' | grep '* index:' -A 1 | grep 'name:' | cut -d '<' -f 2 | rev | cut -c2- | rev)
        for SINK_INPUT in "${SINK_INPUT_LIST[@]}"; do
            pacmd move-sink-input $SINK_INPUT $CURRENT_SINK_NAME
        done

        # Load Notify Script
        SCRIPT_PATH=${0%/*}
        source "$SCRIPT_PATH/notify.sh"
        # Notify the change of audio sink
        notify "Volume" "audio-volume-medium" "Volume" "Audio changed to: $AUDIO_SINK_TYPE"
    fi
else
    kill -9 $(echo "$AUDIO_SINK_RUNNING" | awk '{print $2}')
fi
