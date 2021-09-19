#!/usr/bin/env bash

#
# DON'T USE THIS SCRIPT WITHOUT CHANGING fstab
#

GLOBALS="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/globals.sh"
source ${GLOBALS}

function enable_parallel_downloads () {
    sudo sed -i '/^#\ParallelDownloads =/{N;s/#//g}' /etc/pacman.conf
}

function init_directory() {
    [[ -d $INSTALL_DIRECTORY ]] && print_error "Install directory already exist"
    mkdir -p ${INSTALL_DIRECTORY} || print_error "Unable to create the install directory"
}

function install_dotfiles () {
    sudo mkdir /usr/share/xsessions
    
    cd "${INSTALL_DIRECTORY}/dotfiles/stow_home" && stow * || print_error "Unable to install dotfiles"

    sudo git clone https://gitlab.com/dev.quentinfranchi/dotfiles "/opt/dotfiles" \
        && cd "/opt/dotfiles/stow_root"
    for directory in $( ls -p | grep / ); do
        CONFLICTS=$(stow --no --verbose ${directory} 2>&1 | awk '/\* existing target is/ {print $NF}')
        for f in ${CONFLICTS[@]}; do
            [[ -f "/${f}" || -L "/${f}" ]] && sudo rm "/${f}"
        done
    done
    sudo stow * || print_error "Unable to install dotfiles"
}

function enable_multilib () {
    sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf
}

function update_mirrors () {
    sudo pacman -Syy --noconfirm
}

function upgrade_system () {
    sudo pacman -Syu --noconfirm
}

function clear_pacman_cache () {
    sudo pacman -Sc --noconfirm
}

## NEW

function check_privileges() {
    if [ "$(id -u)" = 0 ]; then
        echo "####################################"
        echo "This script MUST NOT be run as root!"
        echo "####################################"
        exit 1
    fi

    sudo echo ""
    [[ ${?} -eq 1 ]] && print_error "Your root password is wrong"
}

number_of_steps=13

## /NEW

check_privileges

enable_parallel_downloads

enable_multilib

update_mirrors

init_directory

sh "scripts/config_keyboard.sh"

sh "scripts/config_system.sh"

sh "scripts/config_lts.sh"

sh "scripts/config_grub.sh"

sh "scripts/config_git.sh"

sh "scripts/config_wm.sh"

sh "scripts/config_lightdm.sh"

sh "scripts/config_apps.sh"

sh "scripts/config_gaming.sh"

sh "scripts/config_aur.sh"

sh "scripts/config_dev.sh"

sh "scripts/config_vm.sh"

# sh "scripts/config_fstab.sh"

clear_pacman_cache
