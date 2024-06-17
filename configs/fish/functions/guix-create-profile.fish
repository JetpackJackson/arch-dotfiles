function guix-create-profile --description 'create a Guix profile in the current directory'
    guix package -m manifest.scm -p .guix-direnv $argv
end

