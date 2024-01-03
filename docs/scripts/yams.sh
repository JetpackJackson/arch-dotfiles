#!/usr/bin/env sh

# launch yambar across all monitors
killall yambar

wlr-randr | grep --no-group-separator -B 5 'Enabled: yes' | sed -n 's/^\(\S\+\).*/\1/p' | xargs -I '{}' sh -c '
tmpfile="$(mktemp "yambar-{}.XXXX.yml" --tmpdir)"
cp ~/.config/yambar/config.yml "$tmpfile"
sed -i "s/^\(\s\+\)height\(:.\+\)$/\1height\2\n\1monitor: {}/" "$tmpfile"
yambar --config="$tmpfile" > /dev/null 2>&1&
'
