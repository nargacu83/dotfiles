#!/bin/bash

function _install_spaceship () {
    # Clone and build Spaceship
    git clone https://aur.archlinux.org/spaceship-prompt-git.git --depth=1 "${INSTALL_DIRECTORY}/spaceship"
    cd "${INSTALL_DIRECTORY}/spaceship"
    makepkg -si --noconfirm --needed
    mkdir -p ${HOME}/.cache/zsh
}

print_message "Configuring system"

_install_spaceship
sudo chsh -s /bin/zsh ${USER}
sudo grub-mkconfig -o /boot/grub/grub.cfg
