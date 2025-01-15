#!/usr/bin/env sh

resolution="2560x1080"
refresh_rate="100"
gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

# launch the given program in the background only if an instance isn't already running
function launch_once() {
  ps x | grep -v grep | grep ${1} &>/dev/null || ${1} &
}

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
  echo "Autostarting for X11"

  if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export _JAVA_AWT_WM_NONEREPARENTING=1
    export QT_QPA_PLATFORMTHEME=qt5ct
    #export GTK_THEME="Catppuccin-Mocha-Standard-Mauve-Dark"
    export GTK_THEME="${gtk_theme//\'/}"

    #set resolution and refresh rate
    if [ -x "$(command -v xrandr)" ]; then
      xrandr -s ${resolution} -r ${refresh_rate}
    fi

    #boot picom if it exists
    if [ -x "$(command -v picom)" ]; then
      picom --daemon --experimental-backend
    fi

    # sxhkd
    if [ -x "$(command -v sxhkd)" ]; then
      sxhkd &
    fi

    # Network manager GUI
    if [ -x "$(command -v nm-applet)" ]; then
      nm-applet --indicator &
    fi

    # set night light
    if [ -x "$(command -v gammastep-indicator)" ]; then
      launch_once gammastep-indicator
    fi

    # Start polkit
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

    # Disable screen sleep
    xset s off
    xset -dpms
    xset s noblank
  else
    # sxhkd
    if [ -x "$(command -v sxhkd)" ]; then
      sxhkd -c ~/.config/sxhkd/plasma.conf &
    fi
  fi

  # enable numlock
  if [ -x "$(command -v numlockx)" ]; then
    numlockx on
  fi

  # bluetooth
  if [ -x "$(command -v blueman-applet)" ]; then
    blueman-applet &
  fi

elif [ "$XDG_SESSION_TYPE" == "wayland" ]; then
  # Hyprland specific
  if [ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]; then
    echo "Autostarting for Hyprland"

    export XDG_SESSION_DESKTOP=Hyprland
  fi

  if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    export XCURSOR_SIZE=22
    export GTK_IM_MODULE=wayland

    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORM=wayland;xcb
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt6ct

    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONEREPARENTING=1
    export CLUTTER_BACKEND=wayland
    export GDK_BACKEND=wayland,x11

    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    if [ -x "$(command -v waybar)" ]; then
      waybar &
    fi
    
    # #set night light
    if [ -x "$(command -v gammastep-indicator)" ]; then
      gammastep-indicator -m wayland &
    fi

    # network manager applet
    if [ -x "$(command -v nm-applet)" ]; then
      nm-applet &
    fi

    # Polkit
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
  fi
fi

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi
