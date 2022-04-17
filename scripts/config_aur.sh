#!/bin/bash

# Installs packages from the Arch User Repository

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_AUR_APPS="
ventoy-bin
itch
joshuto
material-maker-bin
"

PKG_AUR_FONTS="
ttf-fork-awesome
nerd-fonts-jetbrains-mono
"

PKG_AUR_STYLE="
dracula-gtk-theme
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
