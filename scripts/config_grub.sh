#!/bin/bash

source "common.sh"

GRUB_RESOLUTION="2560x1080"
GRUB_OPTIONS="--boot --theme vimix --screen ultrawide"

function _install_custom_grub () {
    cd ${INSTALL_DIRECTORY}
    sudo sed -i -e "s/GRUB_GFXMODE=auto/GRUB_GFXMODE=$GRUB_RESOLUTION,auto/g" /etc/default/grub
    git clone https://github.com/vinceliuice/grub2-themes
    cd "${INSTALL_DIRECTORY}/grub2-themes"
    sudo ./install.sh ${GRUB_OPTIONS}
}

print_message "Configuring grub"

_install_custom_grub
sudo grub-mkconfig -o /boot/grub/grub.cfg