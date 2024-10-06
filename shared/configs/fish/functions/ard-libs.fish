function ard-libs --wraps='' --description 'show all matching libraries'
    arduino-cli lib search $1 $argv | less
end
