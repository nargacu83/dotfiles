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
maim
libqalculate
openssh
converseen
btop
neofetch
onefetch
radeontop
yt-dlp
qbittorrent
flatpak
gitui
"

PKG_APPS_FLATPAK="
io.freetubeapp.FreeTube
com.github.tchx84.Flatseal
com.discordapp.Discord
com.github.micahflee.torbrowser-launcher
com.obsproject.Studio
io.dbeaver.DBeaverCommunity
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
"

PKG_APPS_OFFICE="
libreoffice-fresh
libreoffice-fresh-fr
"


function install_firefox_gnome_theme () {
    git clone https://github.com/rafaelmardojai/firefox-gnome-theme ~/firefox-gnome-theme/ && ~/firefox-gnome-theme/scripts/install.sh
}

print_message "Configuring apps"

sudo pacman -S --needed --noconfirm ${PKG_APPS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_BROWSER}
sudo pacman -S --needed --noconfirm ${PKG_APPS_GRAPHICS}
sudo pacman -S --needed --noconfirm ${PKG_APPS_FILE_MANAGER}
sudo pacman -S --needed --noconfirm ${PKG_SOCIAL}
sudo pacman -S --needed --noconfirm ${PKG_APPS_OFFICE}

flatpak install -y ${PKG_APPS_FLATPAK}

install_firefox_gnome_theme
