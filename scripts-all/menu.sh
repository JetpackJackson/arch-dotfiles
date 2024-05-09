#!/usr/bin/env bash
# requires acpi
#echo -e 'lock\nloginctl poweroff\nloginctl reboot\nswaymsg exit' | fzf --reverse --preview="date +'%H:%M:%S %A %d %B (%m) %Y ';acpi | sed 's/Battery 0: //;s/until charged//;s/remaining//'" --preview-window=up:wrap:noborder | sh
echo -e 'foo\nfoobar' | fzf --reverse --preview="date +'%H:%M:%S %A %d %B (%m) %Y ';echo $(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status) \($(cat /sys/class/power_supply/BAT0/technology)\);" --preview-window=up:wrap:noborder | sh
