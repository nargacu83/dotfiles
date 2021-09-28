#!/bin/bash

# Installs Window Manager packages

# Sourcing path is relative to install.sh
source ./globals.sh


function install_dotfiles () {
    sudo mkdir /usr/share/xsessions
    
    cd stow_home && stow * || print_error "Unable to install dotfiles"

    sudo git clone https://gitlab.com/dev.quentinfranchi/dotfiles "/opt/dotfiles" && cd "/opt/dotfiles/stow_root"
    for directory in $( ls -p | grep / ); do
        CONFLICTS=$(stow --no --verbose ${directory} 2>&1 | awk '/\* existing target is/ {print $NF}')
        for f in ${CONFLICTS[@]}; do
            [[ -f "/${f}" || -L "/${f}" ]] && sudo rm "/${f}"
        done
    done
    sudo stow * || print_error "Unable to install dotfiles"
}

function install_themes () {
    echo "Placeholder"
}

print_message "Installing dotfiles"
install_dotfiles
install_themes