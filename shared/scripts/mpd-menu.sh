#!/usr/bin/env bash

while : ; do
    part1=/home/jet/music/
    part2=$(mpc -f %file% | head -n 1)
    file=$part1$part2
    ffmpeg -y -loglevel quiet -i "$file" -an -c:v copy /tmp/file.jpg
#    mpc -f "%artist% - %title% - %file%" current

    # Gets the current status of mpd (for us to parse it later on)
    status="$(mpc status)"
    #status="$(mpc --host $(pass mpd)@192.168.0.46 status)"
    # Defines the Play / Pause option content
    if [[ $status == *"[playing]"* ]]; then
            play_pause="pause (playing)"
    else
            play_pause="play (paused)"
    fi

    # Display if repeat mode is on / off
    if [[ $status == *"repeat: on"* ]]; then
            tog_repeat="repeat on"
    elif [[ $status == *"repeat: off"* ]]; then
            tog_repeat="repeat off"
    else
            tog_repeat=" Parsing error"
    fi

    # Display if random mode is on / off
    if [[ $status == *"random: on"* ]]; then
            tog_random="random on"
    elif [[ $status == *"random: off"* ]]; then
            tog_random="random off"
    else
            tog_random=" Parsing error"
    fi

    # Variable passed to fzf
    options="previous\nnext\n$play_pause\n$tog_repeat\n$tog_random\nreload_music\nalbum"
    #options="previous\nnext\n$play_pause\n$tog_repeat\n$tog_random\nreload_music\ndelete"

    # Spawn the mpd menu with the "Play / Pause" entry selected by default
#    chosen="$(echo -e "$options" | fzf --preview='./docs/scripts/cat-album-art.sh' --preview-window=up:wrap:noborder)"

    #$LESSER=$($COLUMNS-5)
#    --preview='kitten icat --clear --transfer-mode=memory --place=30x30@30x0 --align center --stdin=no --hold /tmp/file.jpg > /dev/tty & mpc -f "%artist% - %title%" current && echo "queued:" && mpc queued' \    
    chosen=$(echo -e "$options" | EXTERNAL_COLUMNS=$COLUMNS \
    fzf \
    --preview='mpc -f "%artist% - %title%" current && echo "queued:" && mpc queued' \
    --preview-window "up,50%,border-left")
#    --preview='kitten icat --clear --transfer-mode=memory --place="$COLUMNS"x"$LINES"@(math $EXTERNAL_COLUMNS-$COLUMNS)x0 --align center --stdin=no --hold /tmp/file.jpg > /dev/tty & mpc -f "%artist% - %title% - %file%" current' \

#fzf --preview='kitten icat --clear --transfer-mode=memory --place="$COLUMNS"x"$LINES"@"$(($EXTERNAL_COLUMNS-$COLUMNS))"x0 --align center --stdin=no {} > /dev/tty' \
#--preview-window "right,50%,border-left")

    #chosen="$(echo -e "$options" | fzf --preview='mpc -f "%artist% - %title% - %file%" current' --preview-window=up:wrap:noborder)"
    case $chosen in
            previous)
                    mpc -q prev
                    ;;
            $play_pause)
                    mpc -q toggle
                    ;;
            next)
                    mpc -q next
                    ;;
            $tog_repeat)
                    mpc -q repeat
                    ;;
            $tog_random)
                    mpc -q random
                    ;;
            reload_music)
                    mpc clear && mpc load stream && mpc play
                    ;;
            album)
                    cat-album-art.sh
                    ;;
            #delete)
            #        delete-current-song
            #        ;;
            "")
                    exit
                    ;;
    esac
done
