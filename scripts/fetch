#!/usr/bin/env bash

if [ ! -d ~/.local/share/cowz/ ]; then
    mkdir -p ~/.local/share/cowz/
fi

if [ ! -f ~/.local/share/cowz/deutsch.dat ]; then
    daikichi pack ~/.local/share/cowz/deutsch ~/.local/share/cowz/deutsch.dat
fi
daikichi randstr ~/.local/share/cowz/deutsch.dat > /tmp/quote.txt
fold -w 34 -s /tmp/quote.txt > /tmp/fold.txt
counter=1
char=-1
filelength=$(wc -l /tmp/fold.txt | awk -F\  '{ print $1 }')
max=$(wc --max-line-length /tmp/fold.txt | awk -F\  '{ print $1 }')

# clear cow if exists
true > /tmp/cow

# kludge
(( max+=2 ))

while read -r line; do
    # top bar
    if [ $counter == 1 ];
    then
        char=-1
        while [ $char -lt $max ];
        do
            printf "-" >> /tmp/cow
            (( char+=1 ))
        done
        printf "\n" >> /tmp/cow
    fi

    #printf '%-*s%s' $max "| $line" " |"
    printf "| %s%*s |" "$line" "$(($max - $(wc -L <<< "$line")-2))" "" >> /tmp/cow
    printf "\n" >> /tmp/cow
    #echo "|" $line
    (( counter+=1 ))

    # bottom bar
    if [ $counter == $((filelength + 1)) ];
    then
        char=-1
        while [ $char -lt $max ];
        do
            printf "-" >> /tmp/cow
            (( char+=1 ))
        done
        (( counter+=1 ))
        printf "\n" >> /tmp/cow
    fi
done < /tmp/fold.txt

# cow time
printf "       \\" >> /tmp/cow
printf "\n" >> /tmp/cow
printf "        \   ^__^\n" >> /tmp/cow
printf "         \  (oo)\_______\n" >> /tmp/cow
printf "            (__)\       )\\/\\"  >> /tmp/cow
printf "\n" >> /tmp/cow
printf "                ||----w |\n"  >> /tmp/cow
printf "                ||     ||\n"  >> /tmp/cow

cowlength=$(wc -l </tmp/cow)
fastfetch --raw /tmp/cow --logo-width 36 --logo-height $cowlength
