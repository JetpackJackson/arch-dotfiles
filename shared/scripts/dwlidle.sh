#!/usr/bin/env fish
#HOSTNAME=$(cat /etc/hostname)
#if [[ $HOSTNAME == "weasel" ]]; then

set HOSTNAME $(cat /etc/hostname)
if test $HOSTNAME = "weasel"
    swayidle -w \
        timeout 300 'swaylock -f --clock --datestr '%d.%m.%Y' --indicator -ef -i "/home/jet/pics/wallpapers/lock.jpg"' \
        timeout 600 'killall yambar && wlr-randr --output eDP-1 --off' resume 'wlr-randr --output eDP-1 --on && notify-send "welcome back!" && fish -c "killall yambar; yambar -c ~/.config/yambar/config-dwl.yml &; disown"' \
        before-sleep 'swaylock -f --clock --datestr '%d.%m.%Y' --indicator -ef -i "/home/jet/pics/wallpapers/lock.jpg"' &; disown
end
#fi
