function fetch --description 'fastfetch + cowsay'
    fortune deutsch | cowsay -W 30 > /tmp/cow
    set cowlength $(cat /tmp/cow | wc -l)
    #set cowlength $(wc -l /tmp/cow | awk '{print $1}')
    fastfetch --raw /tmp/cow --logo-width 30 --logo-height $cowlength
    #fortune deutsch | cowsay -W 30 | fastfetch --file -
end
