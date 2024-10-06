# more music
function skipto --wraps='mpc searchplay $1' --description 'alias skipto=mpc searchplay $1'
  mpc searchplay $1 $argv
end
