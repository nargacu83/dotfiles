#!/bin/bash

# Applications packages

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

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
firefox
converseen
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

function install_librewolf_gnome_theme () {
    cd ${INSTALL_DIRECTORY}
    git clone https://github.com/rafaelmardojai/firefox-gnome-theme/ && cd firefox-gnome-theme && ./scripts/install.sh -f ~/.librewolf
}

function _install_doom_emacs () {
}

print_message "Configuring apps"

sudo pacman -S --needed --noconfirm ${PKG_APPS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_GRAPHICS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_FILE_MANAGER}
sudo pacman -S --needed --noconfirm ${PKG_SOCIAL}
sudo pacman -S --needed --noconfirm ${PKG_APPS_OFFICE}