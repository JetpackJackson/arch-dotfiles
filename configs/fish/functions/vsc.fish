# old vscode stuff that I might need
function vsc --wraps='vscodium --extensions-dir /home/jet/.local/share/vscode' --description 'alias vsc=vscodium --extensions-dir /home/jet/.local/share/vscode'
  vscodium --extensions-dir /home/jet/.local/share/vscode $argv
end
