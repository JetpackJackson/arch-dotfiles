function a --wraps='nvim $ZETTELKASTEN/agenda.md' --wraps='cd $ZETTELKASTEN/ && nvim agenda.md' --description 'alias a=cd $ZETTELKASTEN/ && nvim agenda.md'
  cd $ZETTELKASTEN/ && nvim agenda.md $argv
        
end
