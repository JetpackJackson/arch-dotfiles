function vsc --wraps='vscodium --extensions-dir "$XDG_DATA_HOME/vscode"' --description 'alias vsc=vscodium --extensions-dir "$XDG_DATA_HOME/vscode"'
  vscodium --extensions-dir "$XDG_DATA_HOME/vscode" $argv
        
end
