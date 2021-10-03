#!/usr/bin/env bash

#
# DON'T USE THIS SCRIPT WITHOUT CHANGING fstab
#

GLOBALS="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/globals.sh"
source ${GLOBALS}

function enable_parallel_downloads () {
    sudo sed -i '/^#\ParallelDownloads =/{N;s/#//g}' /etc/pacman.conf
}

function init_install_directory() {
    [[ -d ${INSTALL_DIRECTORY} ]] && print_error "Install directory already exist"
    mkdir -p ${INSTALL_DIRECTORY} || print_error "Unable to create the install directory"
}

function remove_install_directory() {
    [[ -d ${INSTALL_DIRECTORY} ]] && rm -rf ${INSTALL_DIRECTORY}
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

check_privileges

enable_parallel_downloads

enable_multilib

update_mirrors

init_install_directory

sh "scripts/config_keyboard.sh"

sh "scripts/config_system.sh"

sh "scripts/config_lts.sh"

sh "scripts/config_grub.sh"

sh "scripts/config_git.sh"

sh "scripts/config_dotfiles.sh"

sh "scripts/config_wm.sh"

sh "scripts/config_lightdm.sh"

sh "scripts/config_apps.sh"

sh "scripts/config_gaming.sh"

# sh "scripts/config_aur.sh"

sh "scripts/config_dev.sh"

sh "scripts/config_vm.sh"

# sh "scripts/config_fstab.sh"

clear_pacman_cache

remove_install_directory

print_message "Don't forget to delete ${FILE_DIRECTORY} after reboot."