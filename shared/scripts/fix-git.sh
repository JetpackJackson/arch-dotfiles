#!/usr/bin/env bash
#git config --local url.ssh://git@codeberg.org/.insteadof https://codeberg.org/
#git config --local url.ssh://git@github.com/.insteadof https://github.com/

# https://gist.github.com/taoyuan/bfa3ff87e4b5611b5cbe
# git config insteadOf
# $1: https/ssh/unset; null to display
# $2: domain name
function git_insteadof()
{
    local url="github.com"
    if [ $# -ge 2 ]; then
        url=$2
    fi
    case $1 in
        ssh)
            git config --local --unset-all url."https://${url}/".insteadof
            git config --local url."git@${url}:".insteadOf "https://${url}/"
            ;;
        https)
            git config --local --unset-all url."git@${url}:".insteadof
            git config --local url."https://${url}/".insteadOf "git@${url}:"
            ;;
        unset)
            git config --local --unset-all url."https://${url}/".insteadof
            git config --local --unset-all url."git@${url}:".insteadof
            ;;
        *)
            echo; git config -l | grep -E "url\.|\.insteadof=" && echo
            ;;
        esac
}
git_insteadof "$@"
