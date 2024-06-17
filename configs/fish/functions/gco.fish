function gco --wraps='git commit -m' --description 'alias git commit -m'
    git commit -m "$argv"
end
