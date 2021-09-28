#!/bin/sh

memory="$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"

echo "[ $memory]"