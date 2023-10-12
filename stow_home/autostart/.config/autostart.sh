#!/usr/bin/env sh

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"
# Java applications fix, i don't remember for what
export _JAVA_AWT_WM_NONREPARENTING=1
# QT Theme
# export QT_STYLE_OVERRIDE="kvantum"
export QT_QPA_PLATFORMTHEME="qt5ct"

resolution="2560x1080"
refresh_rate="100"
wallpapers_directory="/mnt/DATA/Nextcloud/Wallpapers/Current"

# launch the given program in the background only if an instance isn't already running
function launch_once() {
  ps x | grep -v grep | grep ${1} &>/dev/null || ${1} &
}

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
  #set resolution and refresh rate
  if [ -x "$(command -v xrandr)" ]; then
    xrandr -s ${resolution} -r ${refresh_rate}
  fi

  if [ "$XDG_CURRENT_DESKTOP" != "KDE" ]; then
    #boot picom if it exists
    if [ -x "$(command -v picom)" ]; then
      picom --daemon --experimental-backend
    fi

    # sxhkd
    if [ -x "$(command -v sxhkd)" ]; then
      sxhkd
    fi

    #set background
    if [ -x "$(command -v nitrogen)" ]; then
      nitrogen --restore &
    fi

    # Start polkit-gnome
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

    # Network manager GUI
    if [ -x "$(command -v nm-applet)" ]; then
      nm-applet --indicator &
    fi

    # #set night light
    if [ -x "$(command -v gammastep-indicator)" ]; then
      launch_once gammastep-indicator
    fi
  else
    # sxhkd
    if [ -x "$(command -v sxhkd)" ]; then
      sxhkd -c ~/.config/sxhkd/plasma.conf
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
  QT_QPA_PLATFORM=qt5ct;wayland;xcb
  GDK_BACKEND=wayland

  # Hyprland specific
  if [ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]; then
    XDG_CURRENT_DESKTOP=Hyprland
    XDG_SESSION_TYPE=wayland
    XDG_SESSION_DESKTOP=Hyprland
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # hyprctl setcursor $XCURSOR_THEME $XCURSOR_SIZE

    if [ -x "$(command -v waybar)" ]; then
      waybar &
    fi
  fi

  # wallpaper
  if [ -x "$(command -v swww)" ]; then
    swww init &
    wallpapers ${wallpapers_directory}
  fi


  # #set night light
  if [ -x "$(command -v gammastep-indicator)" ]; then
    gammastep-indicator -m wayland &
  fi
fi


#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# multilingual inputs
if [ -x "$(command -v fcitx5)" ]; then
  fcitx5 -d &
fi

# REPLACED BY SYSTEMD SERVICE
# audio management
# if [ -x "$(command -v easyeffects)" ]; then
#   easyeffects --gapplication-service &
# fi
