#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that handles volume of master channel and echo it

CURRENT_VOL=$(amixer get Master | grep 'Left' | awk '$0~/%/{print $5}' | tr -d '[]' | cut -d'%' -f 1)
if [[ $CURRENT_VOL -ge 11 ]] && [[ $CURRENT_VOL -le 30 ]]; then
    echo ""
elif [[ $CURRENT_VOL -ge 31 ]] && [[ $CURRENT_VOL -le 60 ]]; then
    echo ""
elif [[ $CURRENT_VOL -ge 61 ]]; then
    echo ""
else
    echo ""
fi
