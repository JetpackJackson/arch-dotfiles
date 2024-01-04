#!/usr/bin/env bash

killall yambar

monitors=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }')
total=$(wlr-randr | grep "^[^ ]" | awk '{ print$1 }' | wc -l)


for monitor in ${monitors}; do
    swaymsg focus output ${monitor}
    yambar > /dev/null 2>&1&
    sleep 0.2
done





##/usr/bin/env sh
## launch yambar across all monitors
#killall yambar
#
#wlr-randr | grep --no-group-separator -B 5 'Enabled: yes' | sed -n 's/^\(\S\+\).*/\1/p' | xargs -I '{}' sh -c '
#tmpfile="$(mktemp "yambar-{}.XXXX.yml" --tmpdir)"
#cp ~/.config/yambar/config.yml "$tmpfile"
#sed -i "s/^\(\s\+\)height\(:.\+\)$/\1height\2\n\1monitor: {}/" "$tmpfile"
#yambar --config="$tmpfile" > /dev/null 2>&1&
#'
