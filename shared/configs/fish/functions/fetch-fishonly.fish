function fetch-fishonly --description 'fastfetch + cowsay'
#    if test ! -f ~/.local/share/cowz/deutsch.dat
#        daikichi pack ~/.local/share/cowz/deutsch ~/.local/share/cowz/deutsch.dat
#    end
#    daikichi randstr ~/.local/share/cowz/deutsch.dat > /tmp/quote.txt
    fortune deutsch > /tmp/quote.txt
    #rust-cowz > /tmp/quote.txt
    fold -w 34 -s /tmp/quote.txt > /tmp/fold.txt
    set -g counter 1
    set -g char -1
    set -g filelength $(wc -l /tmp/fold.txt | awk -F\  '{ print $1 }')
    #set -g max $(wc --max-line-length /tmp/fold.txt | awk -F\  '{ print $1 }')
    set -g max $(awk '{ if (length($0) > max) max = length($0) } END { print max }' /tmp/fold.txt)

    # clear cow if exists
    true > /tmp/cow

    # kludge
    set max (math $max + 2)

    while read -la line
        # top bar
        if test "$counter" -eq 1
            printf " " >> /tmp/cow
            set char -1 #(math $char - 1)
            while test "$char" -lt (math "$max" - 1)
                printf "-" >> /tmp/cow
                set char (math $char + 1)
            end
            #printf "." >> /tmp/cow
            printf "\n" >> /tmp/cow
        end

        #printf "| %s%*s |" "$line" "math $($max - $(wc -L <<< "$line")-2)" "" >> /tmp/cow

        #set foo (echo "$line" | wc -L)# | awk -F\  '{ print $1 }')
        #set foo (wc -L "$line" | psub)# | awk -F\  '{ print $1 }')
        set foo (wc -L (echo $line | psub) | awk -F\  '{ print $1 }')
        set num (math $max - $foo)
        set num (math $num - 2)
        printf "| %s%*s |" "$line" "$num" "" >> /tmp/cow
        #printf "| %s%*s |" "$line" "$(($max - $(wc -L <<< "$line")-2))" "" >> /tmp/cow
        printf "\n" >> /tmp/cow
        set counter (math $counter + 1)

        # bottom bar
        if test "$counter" -eq (math $filelength + 1)
            printf " " >> /tmp/cow
            set char -1 #(math $char - 1)
            while test "$char" -lt (math "$max" - 1)
                printf "-" >> /tmp/cow
                set char (math $char + 1)
            end
            set counter (math $counter + 1)
            #printf "'" >> /tmp/cow
            printf "\n" >> /tmp/cow
        end
    end </tmp/fold.txt

    # cow time
    printf "       \\" >> /tmp/cow
    printf "\n" >> /tmp/cow
    printf "        \   ^__^\n" >> /tmp/cow
    printf "         \  (oo)\_______\n" >> /tmp/cow
    printf "            (__)\       )\\/\\"  >> /tmp/cow
    printf "\n" >> /tmp/cow
    printf "                ||----w |\n"  >> /tmp/cow
    printf "                ||     ||\n"  >> /tmp/cow

    set cowlength $(wc -l </tmp/cow)
    #set SHELL /usr/bin/fish
    fastfetch --raw /tmp/cow --logo-width 36 --logo-height $cowlength

end

