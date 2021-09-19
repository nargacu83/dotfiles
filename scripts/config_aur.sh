#!/bin/bash

# Installs packages from the Arch User Repository

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

PKG_AUR_APPS="
librewolf-bin
freetube-bin
vscodium-bin
vscodium-bin-marketplace
etcher-bin"

PKG_AUR_FONTS="
ttf-fork-awesome
"

PKG_AUR_STYLE="
adwaita-qt
"

function _install_paru () {
    cd ${INSTALL_FOLDER}
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm --needed
}

print_message "Configuring AUR related packages"

_install_paru
paru -S --noconfirm --noprovides --skipreview $PKG_AUR_APPS
paru -S --noconfirm --noprovides --skipreview $PKG_AUR_FONTS
paru -S --noconfirm --noprovides --skipreview $PKG_AUR_STYLE