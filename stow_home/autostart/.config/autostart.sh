#!/usr/bin/env sh

resolution="2560x1080"
refresh_rate="100"

# launch the given program in the background only if an instance isn't already running
function launch_once() {
  ps x | grep -v grep | grep ${1} &>/dev/null || ${1} &
}

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
  echo "Autostarting for X11"

  export GTK_IM_MODULE="fcitx"
  export QT_IM_MODULE="fcitx"
  export XMODIFIERS="@im=fcitx"

  if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export _JAVA_AWT_WM_NONEREPARENTING=1
    export QT_QPA_PLATFORMTHEME=qt5ct

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

    # multilingual inputs
    if [ -x "$(command -v fcitx5)" ]; then
      fcitx5 -d &
    fi

    # set night light
    if [ -x "$(command -v gammastep-indicator)" ]; then
      launch_once gammastep-indicator
    fi

    # sync
    if [ -x "$(command -v syncthingtray)" ]; then
      syncthingtray --wait --replace &
    fi

    # Start polkit
    /usr/lib/polkit-kde-authentication-agent-1 &

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

  # River specific
  # if [ "$XDG_CURRENT_DESKTOP" == "river" ]; then
  #   echo "Autostarting for river"

  #   export XDG_SESSION_DESKTOP=river
  # fi

  # Hyprland specific
  if [ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]; then
    echo "Autostarting for Hyprland"

    export XDG_SESSION_DESKTOP=Hyprland
  fi

  if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    export XCURSOR_SIZE=22
    export GTK_IM_MODULE=wayland
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"

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

    # multilingual inputs
    if [ -x "$(command -v fcitx5)" ]; then
      fcitx5 -d &
    fi

    # network manager applet
    if [ -x "$(command -v nm-applet)" ]; then
      nm-applet &
    fi

    # sync
    if [ -x "$(command -v syncthingtray)" ]; then
      syncthingtray --wait --replace &
    fi

    # Polkit
    /usr/lib/polkit-kde-authentication-agent-1 &

    # wallpaper
    #if [ -x "$(command -v swww)" ]; then
    #  wallpapers "${wallpapers_directory}" &
    #fi
  fi
fi

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi
# REPLACED BY SYSTEMD SERVICE
# audio management
# if [ -x "$(command -v easyeffects)" ]; then
#   easyeffects --gapplication-service &
# fi
