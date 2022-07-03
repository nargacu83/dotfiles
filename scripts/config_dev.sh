#!/bin/bash

# Installs development related packages

# Sourcing path is relative to install.sh
source ./globals.sh

function install_doom_emacs () {
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d \
        && ~/.emacs.d/bin/doom -y install \
        && ~/.emacs.d/bin/doom sync
}

print_message "Configuring developement"

install_doom_emacs
