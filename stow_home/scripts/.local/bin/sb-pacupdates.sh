#!/bin/sh

pacupdates=$(checkupdates | wc -l)

if [ $pacupdates -eq 0 ]; then
    echo ""
else
    echo "$pacupdates MAJs "
fi
