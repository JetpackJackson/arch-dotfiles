function ard-com --wraps='arduino-cli compile -m $argv' --description 'arduino stuff'
    arduino-cli compile -m $argv
end
