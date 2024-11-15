#/bin/bash

rsync -avxHAXP --exclude '.git*' .* ~/ # add --delete flag
