#!/bin/sh

battery_left=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "to\ empty" | awk -F ':' '{print $2}' | sed -e 's/^[ \t]*//')

if [ -n "$battery_left" ]; then
    echo "$battery_left"
else
    echo "No battery"
fi
