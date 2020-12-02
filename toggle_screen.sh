#!/bin/bash

intern=eDP
extern=HDMI-A-0

if xrandr | grep "$extern disconnected"; then
    echo 'mobile'
    xrandr --output "$extern" --off --output "$intern" --auto
else
    echo 'docked'
    xrandr --output "$intern" --primary --auto --output "$extern" --right-of "$intern" --auto
fi
