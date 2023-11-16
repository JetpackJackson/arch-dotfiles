function loadmusic --wraps='mpc load $1 & mpc play' --wraps='mpc load $1 ; mpc play' --wraps='mpc load $1; mpc play' --wraps='mpc load $1' --description 'alias loadmusic=mpc load $1'
  mpc load $1 $argv
        
end
