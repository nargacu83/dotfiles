#!/bin/sh

pacupdates=$(checkupdates | wc -l)

[ $pacupdates -eq 1 ] && sufix="update" || sufix="updates"

echo "[ $pacupdates $sufix]"