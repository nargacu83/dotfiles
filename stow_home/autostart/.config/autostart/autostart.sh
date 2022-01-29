#!/bin/bash

# Status bar
statusbar &

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

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# easyeffects
if [ -x "$(command -v easyeffects)" ]; then
  easyeffects --gapplication-service -l MonPetitProfil &
  setmicvolume
fi

#set redshift for night light
if [ -x "$(command -v redshift)" ]; then
  redshift-gtk &
fi

#start emacs deamon
if [ -x "$(command -v emacs)" ]; then
  emacs --daemon &
fi

#start pcmanfm deamon
if [ -x "$(command -v pcmanfm)" ]; then
  pcmanfm -d &
fi
