#!/bin/bash

rsync -avxHAXP --exclude '.git*' .* ~/

