function c --wraps='nvim $XDG_CONFIG_HOME/nvim/init.lua' --wraps='cd $XDG_CONFIG_HOME/nvim/ && nvim init.lua' --description 'alias c=cd $XDG_CONFIG_HOME/nvim/ && nvim init.lua'
  cd $XDG_CONFIG_HOME/nvim/ && nvim init.lua $argv
        
end
