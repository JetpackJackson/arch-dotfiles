function ecg --description 'emacsclient gui'
    emacsclient -c $argv &; disown
end
