#!/bin/bash
choice=0
review=0

dryVerboseBackup="-aAXHvun --delete --exclude-from=$XDG_DOCUMENTS_DIR/rsync-list.txt /home/jet/$2/ /run/media/jet/$1/sharky/home/jet/$2/"

realVerboseBackup="-aAXHvu --delete --exclude-from=$XDG_DOCUMENTS_DIR/rsync-list.txt /home/jet/$2/ /run/media/jet/$1/sharky/home/jet/$2/"

dryProgressBackup="-aAXHun --info=progress2 --delete --exclude-from=$XDG_DOCUMENTS_DIR/rsync-list.txt /home/jet/$2/ /run/media/jet/$1/sharky/home/jet/$2/"

realProgressBackup="-aAXHu --info=progress2 --delete --exclude-from=$XDG_DOCUMENTS_DIR/rsync-list.txt /home/jet/$2/ /run/media/jet/$1/sharky/home/jet/$2/"

backup() {
    echo "1: Review and backup (verbose)"
    echo "2: Review and backup (progress bar)"
    echo "3: View progress of writeback"
    read choice
    case "$choice" in
        1) sudo rsync $dryVerboseBackup
           echo "Continue with backup? [y/n] "
           read review
           if [[ $review == "y" ]]
           then
               sudo rsync $realVerboseBackup
           else
               echo "Exiting."
           fi
        ;;
        2) sudo rsync $dryProgressBackup
           echo "Continue with backup? [y/n] "
           read review
           if [[ $review == "y" ]]
           then
               sudo rsync $realProgressBackup
           else
               echo "Exiting."
           fi
        ;;
        3) watch -d grep -e Dirty: -e Writeback: /proc/meminfo
        ;;
        *) echo "Exiting."
        ;;
    esac

}

checkMount() {
    if grep -qs "/run/media/jet/$1" /proc/mounts; then
        echo "Drive '$1' is mounted."
        backup "$1" "$2"
    else
        echo "Drive '$1' is not mounted."
    fi
}

checkMount "$1" "$2"
