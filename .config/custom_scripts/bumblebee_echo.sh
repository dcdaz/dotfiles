#!/bin/sh

# Author : Daniel Córdova A.
# E-Mail : danesc87@gmail.com
# Github : @danesc87
# Released under GPLv3

# Script that echoes Nvidia Logo

# This script needs 'nvidia-smi'
NVIDIA_QUERY=$(nvidia-smi -q -d TEMPERATURE)

CURRENT_TEMPERATURE=$(echo "$NVIDIA_QUERY" | grep "GPU Current Temp" | cut -d ':' -f 2 | cut -d ' ' -f 2)
if [[ ! -z "$CURRENT_TEMPERATURE" ]]; then
    echo "/usr/share/icons/Papirus/24x24/apps/nvidia.svg"
else
    echo ""
fi
