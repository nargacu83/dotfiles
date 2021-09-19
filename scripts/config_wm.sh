#!/bin/bash

# Installs Window Manager packages

source "common.sh"

PKG_WM="
sxhkd
awesome
"

function install_dwm () {
    cd ${INSTALL_DIRECTORY}

    # Install dwm
    git clone --recurse-submodules https://gitlab.com/dev.quentinfranchi/dwm "${INSTALL_DIRECTORY}/dwm"
    
    cd "${INSTALL_DIRECTORY}/dwm/dwm" && suckupdate
}

print_message "Configuring window manager"

sudo pacman -S --needed --noconfirm ${PKG_WM}