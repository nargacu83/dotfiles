#!/usr/bin/env sh
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland;xcb
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_AWT_WM_NONREPARENTING=1
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

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

#start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# # bluetooth TODO: Find alternative that support Wayland.
# if [ -x "$(command -v blueman-applet)" ]; then
#   blueman-applet &
# fi

# multilingual inputs
if [ -x "$(command -v fcitx5)" ]; then
  fcitx5 -d &
fi

# Atomic
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
