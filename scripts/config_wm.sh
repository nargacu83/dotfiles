#!/bin/bash

# Installs Window Manager packages

# Sourcing path is relative to install.sh
source ./globals.sh

function install_dwm () {
    for _pkg in $PKG_DWM; do
        git clone --recurse-submodules https://gitlab.com/dev.quentinfranchi/${_pkg} "${INSTALL_DIRECTORY}/${_pkg}" \
            && cd "${INSTALL_DIRECTORY}/${_pkg}/${_pkg}" && suckupdate || print_error "Unable to install ${_pkg}"
    done
}

print_message "Configuring window manager"
install_dwm
