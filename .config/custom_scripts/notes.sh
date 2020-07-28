#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script to execute custom python notes app when user clicks notes executor of tint2

SCRIPT_PATH=${0%/*}

# Common options
NOTES_FILE_PATH="$HOME/.local/share/notes"
NOTES_APP_NAME='notes.py'
NOTES_RUNNING=$(ps aux | grep -i "$NOTES_APP_NAME" | grep -E 'python3')

if [[ -z "$NOTES_RUNNING" ]]; then
    exec python3 "$SCRIPT_PATH/$NOTES_APP_NAME" "$NOTES_FILE_PATH" > /dev/null &
else
    kill -9 $(echo "$NOTES_RUNNING" | awk '{print $2}')
fi

