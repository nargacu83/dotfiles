#!/bin/bash

# Installs Window Manager packages

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

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