#!/usr/bin/env bash
killall yambar
CONFIG=$HOME/.config/yambar/config-$(cat /etc/hostname).yml
swaymsg -t get_outputs -r | jq -r '.[] | .name' | while read out ; do
  out_config=/tmp/yambar-config-$out.yml
  cat $CONFIG | sed "s/###monitor: .*$/monitor: $out/" > $out_config
  yambar --config=$out_config &
done
