#!/bin/bash

# Installs Window Manager packages

# Sourcing path is relative to install.sh
source ./globals.sh

dotfiles_directory="${HOME}/.dotfiles"
dotfiles_root_directory="/opt/dotfiles"

function install_dotfiles () {
    print_message "Installing user dotfiles"

    # Remove stow root directory
    [[ -d "stow_root" ]] && rm -rf stow_root
    
    # move and install user of the dotfiles
    mv stow_home "${dotfiles_directory}" && \
        cd "${dotfiles_directory}" \
        && stow * || print_error "Unable to install dotfiles"
    
    print_message "Installing root dotfiles"

    [ -d /usr/share/xsessions ] || sudo mkdir /usr/share/xsessions

    [[ -d "${dotfiles_root_directory}_temp" ]] && rm -rf "${dotfiles_root_directory}_temp"

    # move and install root part of the dotfiles
    sudo git clone https://gitlab.com/dev.quentinfranchi/dotfiles "${dotfiles_root_directory}_temp" \
        && mv "${dotfiles_root_directory}_temp/stow_root" "${dotfiles_root_directory}" \
        && rm -rf "${dotfiles_root_directory}_temp" \
        && cd "${dotfiles_root_directory}"

    for directory in $( ls -p | grep / ); do
        CONFLICTS=$(stow --no --verbose ${directory} 2>&1 | awk '/\* existing target is/ {print $NF}')
        for f in ${CONFLICTS[@]}; do
            [[ -f "/${f}" || -L "/${f}" ]] && sudo rm "/${f}"
        done
    done
    sudo stow * || print_error "Unable to install dotfiles"
}

install_dotfiles