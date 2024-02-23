#!/usr/bin/env bash

# script to notify of layout changes for yambar
# requires evtest
KEYBOARD=/dev/input/by-path/platform-i8042-serio-0-event-kbd
CAPS_PRESS="type 17 (EV_LED), code 1 (LED_CAPSL), value 1"
CAPS_NO="type 17 (EV_LED), code 1 (LED_CAPSL), value 0"
SWITCH="type 1 (EV_KEY), code 97 (KEY_RIGHTCTRL), value 1"
META="type 1 (EV_KEY), code 125 (KEY_LEFTMETA), value 1"
SHIFT="type 1 (EV_KEY), code 42 (KEY_LEFTSHIFT), value 1"
TAB="type 1 (EV_KEY), code 15 (KEY_TAB), value 1"

#evtest "$KEYBOARD" | \
if [ "$(cat /etc/hostname)" == "greyfox" ]; then
    layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name' | tail -n 1)
    if [ "$layout" == "English (US)" ]; then
        echo "kbd|string|en"
        echo ""
    elif [ "$layout" == "German (Bone)" ]; then
        echo "kbd|string|de"
        echo ""
    fi
    evtest /dev/input/event2 | \
    while read line
    do
        case "$line" in
    #        *"$META")
    #            echo meta
    ##            evtest /dev/input/event9 | \
    ##            while read line
    ##            do
    ##                if [[ "$line" == *"$SHIFT" ]]
    ##                then
    ##                    echo shift
    ##                    evtest /dev/input/event9 | \
    ##                    while read line
    ##                    do
    ##                        if [[ "$line" == *"$TAB" ]]
    ##                        then
    ##                            echo tab
    ##                            notify-send -u low "scratch"
    ##                        fi
    ##                    done
    ##                fi
    ##                else;
    ##                    break
    ##            done
    #            ;;
    #        *$CAPS_PRESS)
    #            echo "caps|string|Caps ON"
    #            echo ""
    #            ;;
    #        *$CAPS_NO)
    #            echo "caps|string|"
    #            echo ""
    #            ;;
            *$SWITCH)
                layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name' | tail -n 1)
                if [ "$layout" == "English (US)" ]; then
                    echo "kbd|string|en"
                    echo ""
                elif [ "$layout" == "German (Bone)" ]; then
                    echo "kbd|string|de"
                    echo ""
                fi
                ;;
            *)
                continue
                ;;
        esac
    done
else
    layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1241:41217:HTLTEK_Usb_Keyboard") | .xkb_active_layout_name' | tail -n 1)
    if [ "$layout" == "English (US)" ]; then
        echo "kbd|string|en"
        echo ""
    elif [ "$layout" == "German (Bone)" ]; then
        echo "kbd|string|de"
        echo ""
    fi
    evtest /dev/input/by-id/usb-HTLTEK_Usb_Keyboard-event-kbd | \
    while read line
    do
        case "$line" in
    #        *"$META")
    #            echo meta
    ##            evtest /dev/input/event9 | \
    ##            while read line
    ##            do
    ##                if [[ "$line" == *"$SHIFT" ]]
    ##                then
    ##                    echo shift
    ##                    evtest /dev/input/event9 | \
    ##                    while read line
    ##                    do
    ##                        if [[ "$line" == *"$TAB" ]]
    ##                        then
    ##                            echo tab
    ##                            notify-send -u low "scratch"
    ##                        fi
    ##                    done
    ##                fi
    ##                else;
    ##                    break
    ##            done
    #            ;;
    #        *$CAPS_PRESS)
    #            echo "caps|string|Caps ON"
    #            echo ""
    #            ;;
    #        *$CAPS_NO)
    #            echo "caps|string|"
    #            echo ""
    #            ;;
            *$SWITCH)
                layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1241:41217:HTLTEK_Usb_Keyboard") | .xkb_active_layout_name' | tail -n 1)
                if [ "$layout" == "English (US)" ]; then
                    echo "kbd|string|en"
                    echo ""
                elif [ "$layout" == "German (Bone)" ]; then
                    echo "kbd|string|de"
                    echo ""
                fi
                ;;
            *)
                continue
                ;;
        esac
    done
fi




###layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1241:41217:HTLTEK_Usb_Keyboard") | .xkb_active_layout_name' | tail -n 1)
###if [ "$layout" == "English (US)" ]; then
###    echo "kbd|string|en"
###    echo ""
###elif [ "$layout" == "German (Bone)" ]; then
###    echo "kbd|string|de"
###    echo ""
###fi
###evtest /dev/input/event9 | \
###while read line
###do
###    case "$line" in
####        *"$META")
####            echo meta
#####            evtest /dev/input/event9 | \
#####            while read line
#####            do
#####                if [[ "$line" == *"$SHIFT" ]]
#####                then
#####                    echo shift
#####                    evtest /dev/input/event9 | \
#####                    while read line
#####                    do
#####                        if [[ "$line" == *"$TAB" ]]
#####                        then
#####                            echo tab
#####                            notify-send -u low "scratch"
#####                        fi
#####                    done
#####                fi
#####                else;
#####                    break
#####            done
####            ;;
####        *$CAPS_PRESS)
####            echo "caps|string|Caps ON"
####            echo ""
####            ;;
####        *$CAPS_NO)
####            echo "caps|string|"
####            echo ""
####            ;;
###        *$SWITCH)
###            layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1241:41217:HTLTEK_Usb_Keyboard") | .xkb_active_layout_name' | tail -n 1)
###            if [ "$layout" == "English (US)" ]; then
###                echo "kbd|string|en"
###                echo ""
###            elif [ "$layout" == "German (Bone)" ]; then
###                echo "kbd|string|de"
###                echo ""
###            fi
###            ;;
###        *)
###            continue
###            ;;
###    esac
###done
