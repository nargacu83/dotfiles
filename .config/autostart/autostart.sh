#!/bin/bash
export SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# sxhkd
if [ -x "$(command -v sxhkd)" ]; then
  sxhkd &
fi

#set resolution and refresh rate
if [ -x "$(command -v xrandr)" ]; then
  xrandr -s 2560x1080 -r 100
fi

#boot picom if it exists
if [ -x "$(command -v picom)" ]; then
  picom --vsync &> /dev/null &
fi

#set background
if [ -x "$(command -v feh)" ]; then
  feh --bg-fill $HOME/.config/wallpaper/background.jpg
fi

#start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#start notification-daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# # start file manager daemon
if [ -x "$(command -v pcmanfm)" ]; then
  pcmanfm -d &
fi

#set redshift for night light
if [ -x "$(command -v redshift)" ]; then
  redshift &
fi

# Polybar
# if [ -x "$(command -v polybar)" ]; then
#   polybar -r mainbar &> /dev/null &
# fi


