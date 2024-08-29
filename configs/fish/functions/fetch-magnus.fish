function fetch-magnus --description 'fastfetch + magneto'
    # sticker from: https://old.reddit.com/r/Xmen97/comments/1dgqhgf/all_stickers_design_complete_which_one_am_i/
    # chafa --symbols vhalf -s 35x25 /home/jet/.config/fish/images/mags-sticker-rm.png > /home/jet/.config/fish/images/mags.sixel
    if test $TERM = "foot"
        fastfetch --raw /home/jet/.config/fish/images/mags.sixel --logo-width 30 --logo-height 15 --color red
    else if test $TERM = "xterm-kitty"
        fastfetch --logo /home/jet/.config/fish/images/mags-sticker-rm.png --logo-type kitty-direct --logo-width 35 --logo-height 15 --color red
    end
end
