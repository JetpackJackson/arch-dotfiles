#!/bin/bash
killall waybar
exec waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
#swaymsg output "*" bg /home/jet/Pictures/archbox.png fill
killall swaybg
exec swaybg -i /home/jet/Pictures/archbox.png -m fill
