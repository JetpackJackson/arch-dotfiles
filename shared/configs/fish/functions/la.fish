# list
function la --wraps=ls --wraps='ls -Al' --description 'alias la=ls -Al'
    ls -Al $argv
end
