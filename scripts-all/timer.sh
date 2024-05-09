#!/usr/bin/env bash

alarmtime="$1"
now=$(timedatectl | awk '{ print $5 }' | head -n1)

while true; do
    now=$(timedatectl | awk '{ print $5 }' | head -n1)
    if [ "$alarmtime" = "$now" ]; then
        notify-send -i mpv "Time's up!"
        break
    fi
done
