#!/usr/bin/env sh

# launch the given program in the background only if an instance isn't already running
launch_once() {
  ps x | grep -v grep | grep ${1} &>/dev/null || ${1} &
}

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
  systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  # if [ -x "$(command -v qs)" ]; then
  #   qs &
  # fi
  # 
  # # #set night light
  # if [ -x "$(command -v gammastep-indicator)" ]; then
  #   gammastep-indicator -m wayland &
  # fi
  #
  # # network manager applet
  # if [ -x "$(command -v nm-applet)" ]; then
  #   nm-applet &
  # fi
  #
  # # Polkit
  # /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi
