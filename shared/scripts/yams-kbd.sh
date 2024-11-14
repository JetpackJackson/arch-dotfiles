#!/usr/bin/bash

pkill -f river-kbd-layout-watcher
#river-kbd-layout-watcher 'English (US)' 'English (US)
#' 'German (Noted)' 'German (Noted)
#' > /tmp/kbd &
river-kbd-layout-watcher 'English (US)' 'kbd|string|English (US)
' 'German (Noted)' 'kbd|string|German (Noted)
' > /tmp/kbd &
#sleep 0.01

#while true; do
    #kbd=$(tail -f /tmp/kbd)
    tail -f /tmp/kbd
    #kbd=$(tail -n1 /tmp/kbd)
    #echo "kbd|string|$kbd"
    #echo ""
#done
