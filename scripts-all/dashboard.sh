#!/usr/bin/env bash
cow=$(fortune deutsch | cowsay)
# https://unix.stackexchange.com/questions/314834/output-something-in-a-loop-until-a-key-is-pressed
#https://unix.stackexchange.com/questions/81167/prevent-text-screen-blinking-when-doing-clear

function watcher()
{
    #lines=$(tput lines)
    while true; do
        date=$(date +'%d.%m.%Y %H:%M:%S')
        bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)
        bat_status=$(cat /sys/class/power_supply/BAT0/status)
        internet=$(iwctl station wlan0 show | grep "Connected network" | tr -s ' ' | sed 's/^ *//;s/ *$//;s/ network / to: /')
        layout=$(swaymsg -t get_inputs | jq 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name' | tr -d '"')
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep % | sed 's/.* \([0-9]\+\)% .*/Volume: \1%/')
        sink=$(pactl get-default-sink)
        mute=$(pactl get-sink-mute @DEFAULT_SINK@)
        workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -d '"')
        scratchpad=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id' | wc -l)
        music="\n$(mpc | head -n2)"

        output="$date\n$bat_percent% ($bat_status)\n$internet\nLayout: $layout\n$volume ($sink)\n$mute$music\nOn workspace: $workspace\nIn scratchpad: $scratchpad\n$cow"
        #output="$(date +'%d.%m.%Y %H:%M:%S')\n$(cat /sys/class/power_supply/BAT0/capacity)% ($(cat /sys/class/power_supply/BAT0/status))\n$(iwctl station wlan0 show | grep "Connected network" | tr -s ' ' | sed 's/^ *//;s/ *$//;s/ network / to: /')\nLayout: $(swaymsg -t get_inputs | jq 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name' | tr -d '"')\n$(pactl get-sink-volume @DEFAULT_SINK@ | grep % | sed 's/.* \([0-9]\+\)% .*/Volume: \1%/') ($(pactl get-default-sink))\n$(pactl get-sink-mute @DEFAULT_SINK@)\nOn workspace: $(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -d '"')\nIn scratchpad: $(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name == "__i3_scratch").floating_nodes[].app_id' | wc -l)\n$cow"
        clear
        echo -e "$output"
        read -t 0.15 -N 1 input
        if [[ $input = "q" ]]; then
            clear
            break
        fi
        #sleep 1
    done
}

watcher
