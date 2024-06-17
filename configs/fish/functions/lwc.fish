# list home dir stuff
function lwc --wraps='ls -A | wc' --description 'alias lwc=ls -A | wc'
  ls -A | wc $argv
end
