#!/bin/bash
output=0
output=$(playerctl -l | head -n 1)
while IFS= read -r line; do
    #echo "$line"" is the line read"
    if [ "$output" == "strawberry" ]
    then
	:
    elif [[ "$output" == "chromium"* ]]
    then
	sleep 1
	dunstify "Now playing:" "$(playerctl metadata --format '{{ artist }} - {{ title }}')"
    else
	sleep 1
	dunstify "Now playing:" "$(playerctl metadata --format '{{ artist }} - {{ title }}')"
    fi
#echo "exited"
done <<< "$output"
