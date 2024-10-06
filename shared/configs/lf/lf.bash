lf() {
    export LF_CD_FILE="/var/tmp/.lfcd-$$"
    command lf "$@"
    if [ -s "$LF_CD_FILE" ]; then
        local DIR="$(realpath -- "$(cat -- "$LF_CD_FILE")")"
        if [ "$DIR" != "$PWD" ]; then
            printf 'cd to %s\n' "$DIR"
            cd "$DIR"
        fi
        rm "$LF_CD_FILE"
    fi
    unset LF_CD_FILE
}
