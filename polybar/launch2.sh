#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
#polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done


if type "xrandr" > /dev/null; then
   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	if [ $m == 'LVDS-1' ] 
	then		
		MONITOR=$m polybar --reload longbar -c /home/jet/.config/polybar/config.ini &
	elif [ $m == 'HDMI-1' ]
	then
		#:
		MONITOR=$m polybar --reload longbar2 -c ~/.config/polybar/config.ini &
	else
		MONITOR=$m polybar --reload longbar -c ~/.config/polybar/config.ini &
	fi     
      done
else
    polybar --reload longbar -c ~/.config/polybar/config &
fi

#;;
#esac


#multi monitor, same bar
#if type "xrandr"; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload example &
#  done
#else
#  polybar --reload example &
#fi

# old launch
#echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
#polybar -c $HOME/.config/polybar/config.ini example 2>&1 | tee -a /tmp/polybar2.log & disown
#echo "Bars launched..."
