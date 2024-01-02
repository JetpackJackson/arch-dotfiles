#!/usr/bin/env bash

# silently kill existing bars if any, and run bars
pkill -2 -f yambar > /dev/null 2>&1
yambar > /dev/null 2>&1 &
yambar -c ~/.config/yambar/config2.yml > /dev/null 2>&1 &


#killall yambar
#
#monitors=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }')
#total=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }' | wc -l)
#
#for monitor in ${monitors}; do
#	riverctl focus-output ${monitor}
#	yambar &
#	sleep 0.2
#done
#if [ "$total" -gt "1" ]; then
#	riverctl focus-output HDMI-A-1
#fi
#exit 0
#

##killall --user="$USER" yambar
##
##wlr-randr \
##    | grep --no-group-separator -B 2 'Enabled: yes' \
##    | sed -n 's/^\(\S\+\).*/\1/p' \
##    | xargs -I '{}' sh -c '
##tmpfile="$(mktemp "yambar-{}.XXXX.yml" --tmpdir)"
##cp ~/.config/yambar/config.yml "$tmpfile"
##sed -i "s/^\(\s\+\)height\(:.\+\)$/\1height\2\n\1monitor: {}/" "$tmpfile"
##yambar --config="$tmpfile"&
##'
