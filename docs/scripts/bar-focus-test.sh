#!/usr/bin/env bash

killall yambar

monitors=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }')
total=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }' | wc -l)


for monitor in ${monitors}; do
    swaymsg focus output ${monitor}
    yambar > /dev/null 2>&1&
    sleep 0.2
done
