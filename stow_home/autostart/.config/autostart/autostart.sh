#!/bin/bash

#set resolution and refresh rate
if [ -x "$(command -v xrandr)" ]; then
  xrandr -s 2560x1080 -r 100
fi

#boot picom if it exists
if [ -x "$(command -v picom)" ]; then
  picom --vsync &
fi

#set background
if [ -x "$(command -v nitrogen)" ]; then
  nitrogen --restore &
fi

#start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# sxhkd
if [ -x "$(command -v sxhkd)" ]; then
  sxhkd &
fi

# Status bar
if [ -x "$(command -v statusbar)" ]; then
  statusbar &
fi

# easyeffects
if [ -x "$(command -v easyeffects)" ]; then
  easyeffects --gapplication-service &
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

# Make sure to synchronize time
timedatectl set-ntp true
