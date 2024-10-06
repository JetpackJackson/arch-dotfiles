function fetch-old --description 'fastfetch + cowsay'
    fortune deutsch | cowsay -W 34 > /tmp/cow
    set cowlength $(cat /tmp/cow | wc -l)
    fastfetch --raw /tmp/cow --logo-width 34 --logo-height $cowlength
end
