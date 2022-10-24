#!/bin/env sh

export QT_QPA_PLATFORMTHEME="qt5ct"
export _JAVA_AWT_WM_NONREPARENTING=1

#set resolution and refresh rate
if [ -x "$(command -v xrandr)" ]; then
  xrandr -s 2560x1080 -r 100
fi

#boot picom if it exists
if [ -x "$(command -v picom)" ]; then
  picom &
fi

#set background
if [ -x "$(command -v nitrogen)" ]; then
  nitrogen --restore &
fi

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# sxhkd
if [ -x "$(command -v sxhkd)" ]; then
  sxhkd -c ~/.config/sxhkd/dwm.conf &
fi

# #set redshift for night light
if [ -x "$(command -v redshift)" ]; then
  redshift-gtk &
fi

if [ -x "$(command -v emacs)" ]; then
  systemctl --user start emacs
fi

if [ -x "$(command -v easyeffects)" ]; then
  systemctl --user start easyeffects
fi

#start polkit
/usr/lib/polkit-kde-authentication-agent-1 &

if [ -x "$(command -v nm-applet)" ]; then
  nm-applet &
fi
