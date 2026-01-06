#!/bin/bash

function rsync {
    command rsync \
        --recursive \
        --times \
        --out-format="Updated: %n" \
        --exclude=sync.sh "$@" 
}

function sudo_rsync {
    command sudo rsync \
        --recursive \
        --times \
        --out-format="Updated: %n" \
        --exclude=sync.sh "$@" 
}


for dir in $(find "$HOME/dotfiles" -mindepth 1 -maxdepth 1 -type d); do
    cd $dir

    # Check there are files to be synced
    [ -f "sync.sh" ] || continue
    
    source sync.sh
done

