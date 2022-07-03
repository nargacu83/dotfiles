#!/bin/bash

# Installs gaming packages

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_GAMING="

"

PKG_GAMING_APPS="

"

print_message "Configuring gaming"

sudo pacman -S --needed --noconfirm ${PKG_GAMING}
sudo pacman -S --needed --noconfirm ${PKG_GAMING_APPS}
