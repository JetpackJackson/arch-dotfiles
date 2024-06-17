function ard-lib1 --wraps='' --description 'search for most likely library'
    arduino-cli lib search $1 $argv | head -n10
end
