#!/usr/bin/env bash

############ testing

# scratchpad script for yambar
#swaymsg floating enable, resize set width 1550 height 850, move scratchpad

#pad=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id')
#count=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id' | wc -l)
#if [ "$pad" == "" ]
#then
#    echo "test|string|"
#    echo ""
#    sleep 1
#else
#    echo "test|string| $count"
#    echo ""
#    sleep 1
#fi

############ old but works
#
## scratchpad script for yambar
## TODO: poll when key combo is pressed, instead of every second
while true; do
    pad=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id')
    count=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id' | wc -l)
    if [ "$pad" == "" ]
    then
        echo "count|string|"
        echo ""
        sleep 1
    else
        echo "count|string| $count"
        echo ""
        sleep 1
    fi
done

###!/bin/sh -e
#count() {
#	swaymsg -r -t get_tree | jq '.nodes[] | select(.name == "__i3") | .nodes[] | select(.name == "__i3_scratch") | .floating_nodes | length'
#}
#
#printf 'count|int|%s\n\n' "$(count)"
#swaymsg -r -m -t SUBSCRIBE '["window"]' | jq -c --unbuffered 'select(.change == "move" or .change == "new" or .change == "close")' | while read -r _; do
#	printf 'count|int|%s\n\n' "$(count)"
#done
