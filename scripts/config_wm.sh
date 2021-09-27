#!/bin/bash

# Installs Window Manager packages

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_WM="
sxhkd
"

function install_dwm () {
    # Install dwm
    git clone --recurse-submodules https://gitlab.com/dev.quentinfranchi/dwm "${INSTALL_DIRECTORY}/dwm"
    
    cd "${INSTALL_DIRECTORY}/dwm/dwm" && suckupdate
}

function install_awesome () {
    git clone https://gitlab.com/dev.quentinfranchi/awesome "${HOME}/.config/awesome"
}

print_message "Configuring window manager"

sudo pacman -S --needed --noconfirm ${PKG_WM}
install_dwm