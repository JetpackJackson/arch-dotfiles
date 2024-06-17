function wget-h --wraps='wget'
    wget --hsts-file="$XDG_DATA_HOME/wget-hsts" 
end
