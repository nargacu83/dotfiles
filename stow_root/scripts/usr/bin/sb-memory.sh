#!/bin/sh

memory="$(free -m | awk '/^Mem:/ {print $3 "MiB / " $2 "MiB"}')"

echo "$memory "