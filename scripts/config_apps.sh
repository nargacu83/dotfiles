#!/bin/bash

# Applications packages

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_APPS="
feh
rofi
redshift
dunst
xclip
sxiv
maim
libqalculate
openssh
converseen
btop
"

PKG_APPS_BROWSER="
firefox
firefox-i18n-fr
"

PKG_APPS_GRAPHICS="
gimp
krita
inkscape
blender
mpv
"

PKG_APPS_FILE_MANAGER="
gvfs
gvfs-smb
gvfs-mtp
tumbler
ffmpegthumbnailer
pcmanfm-gtk3
file-roller
filelight
"

PKG_SOCIAL="
element-desktop
discord
"

PKG_APPS_OFFICE="
libreoffice-fresh
"

print_message "Configuring apps"

sudo pacman -S --needed --noconfirm ${PKG_APPS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_BROWSER}
sudo pacman -S --needed --noconfirm ${PKG_APPS_GRAPHICS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_FILE_MANAGER}
sudo pacman -S --needed --noconfirm ${PKG_SOCIAL}
sudo pacman -S --needed --noconfirm ${PKG_APPS_OFFICE}