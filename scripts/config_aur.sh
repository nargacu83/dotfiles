#!/bin/bash

# Installs packages from the Arch User Repository

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_AUR_APPS="
freetube
vscodium-bin
vscodium-bin-marketplace
etcher-bin"

PKG_AUR_FONTS="
ttf-fork-awesome
"

PKG_AUR_PRINTER="
epson-inkjet-printer-escpr
"

PKG_AUR_STYLE="
dracula-gtk-theme
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