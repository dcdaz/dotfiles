#!/bin/sh

# Simple script that creates a notification
# It takes 4 parameters to work
# App Name, Icon Name, Summary and Body in that order

function notify() {
    if [ ! -z "$1" ] && [ ! -z "$2" ] && [ ! -z "$3" ] && [ ! -z "$4" ]; then
        set -x
        gdbus call --session \
            --dest org.freedesktop.Notifications \
            --object-path /org/freedesktop/Notifications \
            --method org.freedesktop.Notifications.Notify \
            "$1" \
            42 \
            "$2" \
            "$3" \
            "$4" \
            [] \
            {} \
            3000 \
            > /dev/null
        set +x
    else
        echo "Notify script needs: App Name, Icon Name, Summary and Body"
    fi
}