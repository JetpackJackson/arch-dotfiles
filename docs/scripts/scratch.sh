#!/usr/bin/env bash

# scratchpad script for yambar
# TODO: poll when key combo is pressed, instead of every second
while true; do
    pad=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id')
    count=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id' | wc -l)
    if [ "$pad" == "" ]
    then
        echo "test|string|"
        echo ""
        sleep 1
    else
        echo "test|string| ($count)"
        echo ""
        sleep 1
    fi
done
