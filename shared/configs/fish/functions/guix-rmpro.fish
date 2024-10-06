function guix-rmpro --description 'delete a Guix profile not in the current directory'
    set dir $(basename $PWD)
    rm -irv $HOME/.guix-extra/$dir/
    rm -irv $HOME/.guix-extra-profiles/$dir/
    direnv revoke
    #rmdir $HOME/.guix-extra/$dir/
end
