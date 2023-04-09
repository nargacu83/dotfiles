#!/usr/bin/env sh
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland;xcb
export QT_QPA_PLATFORMTHEME=qt5ct;qt6ct
export _JAVA_AWT_WM_NONREPARENTING=1

#set background
if [ -x "$(command -v hyprpaper)" ]; then
  hyprpaper &
fi

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# bar
if [ -x "$(command -v waybar)" ]; then
  waybar &
fi

if [ -x "$(command -v gammastep-indicator)" ]; then
  gammastep-indicator -m wayland &
fi

if [ -x "$(command -v nm-applet)" ]; then
  nm-applet --indicator &
fi

# # bluetooth
# if [ -x "$(command -v blueman-applet)" ]; then
#   blueman-applet &
# fi

if [ -x "$(command -v emacs)" ]; then
  systemctl --user start emacs
fi

if [ -x "$(command -v easyeffects)" ]; then
  systemctl --user start easyeffects
fi

#start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
