#!/bin/bash
killall waybar
exec waybar -c ~/.config/waybar/aerzte -s ~/.config/waybar/aerzte.css
output "*" bg /home/jet/Pictures/drum2.png fill
