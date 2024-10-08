#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
if [[ $HOSTNAME == "weasel" ]]; then
swayidle -w \
    timeout 300 'swaylock -f --clock --datestr '%d.%m.%Y' --indicator -ef -i "/home/jet/pics/wallpapers/lock.jpg"' \
    timeout 600 'wlr-randr --output eDP-1 --off' resume 'wlr-randr --output eDP-1 --on' \
    before-sleep 'swaylock -f --clock --datestr '%d.%m.%Y' --indicator -ef -i "/home/jet/pics/wallpapers/lock.jpg"'
fi
