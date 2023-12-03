#!/bin/bash

KEYBOARD=/dev/input/by-path/platform-i8042-serio-0-event-kbd
EVENT="type 17 (EV_LED), code 1 (LED_CAPSL), value 1"

evtest "$KEYBOARD" | \
while read line
do
    if [[ "$line" == *"$EVENT" ]]
    then
        notify-send -u low "Caps Lock ON"
    fi
done
