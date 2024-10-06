function ard-up --wraps='arduino-cli compile -m $argv && arduino-cli upload && arduino-cli monitor' --description 'arduino stuff'
    arduino-cli compile -m $argv && arduino-cli upload && arduino-cli monitor
end
