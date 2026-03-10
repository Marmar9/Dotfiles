#!/bin/env bash

for file in $(find . -type f ! -name "sync.sh") ; do
    rsync --no-o --no-g $file ~/.$(basename $file)
done

