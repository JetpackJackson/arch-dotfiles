#!/usr/bin/env bash
date=$(date "+%Y.%d.%m")
clock=$(date "+%H:%M %A")

#battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_status=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}')
if [ ! -d "/home/jet/music/external/Cro" ]; then
    mpc="nothing playing"
else
    mpc=$(mpc -f "%artist% - %title%" | head -n 1)
    mpc+=$(mpc status " (%currenttime%/%totaltime%)" | head -n 1)
fi
audio_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep % | awk -F "/" '{print $2}')
echo $mpc\ \ \ \ \ $audio_volume\ \ \ \ \ $battery_status\ \ \ \ \ $date\ \ \ \ \ $clock \ 
