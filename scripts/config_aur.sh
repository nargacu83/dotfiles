#!/bin/bash

# Installs packages from the Arch User Repository

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_AUR_APPS="

"

PKG_AUR_FONTS="

"

PKG_AUR_STYLE="

"

PKG_AUR_PRINTER="
epson-inkjet-printer-escpr
"

function _install_paru () {
    cd ${INSTALL_FOLDER}
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm --needed
}

print_message "Configuring AUR related packages"

_install_paru
paru -S --noconfirm --noprovides --skipreview ${PKG_AUR_APPS}
paru -S --noconfirm --noprovides --skipreview ${PKG_AUR_FONTS}
paru -S --noconfirm --noprovides --skipreview ${PKG_AUR_STYLE}
paru -S --noconfirm --noprovides --skipreview ${PKG_AUR_PRINTER}
