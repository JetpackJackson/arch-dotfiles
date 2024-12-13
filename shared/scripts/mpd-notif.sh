#!/usr/bin/env bash

songpath="/home/$USER/music/"$(mpc -f "%file%" | head -n1)
playstatus=$(mpc -f "" | head -n2 | awk '{ print $1 }' | tr -d \\n)
ffmpeg -i "$songpath" -an -vcodec copy /tmp/cover.jpg
if [[ $playstatus == "[playing]" ]]; then
    mpc pause
    notify-send -i /tmp/cover.jpg "Paused:" "$(mpc current)"
elif [[ $playstatus == "[paused]" ]]; then
    mpc play
    notify-send -i /tmp/cover.jpg "Now Playing:" "$(mpc current)"
fi
