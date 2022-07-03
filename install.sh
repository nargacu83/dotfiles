#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
# Styles
NC='\033[0m' # No Color
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Global variables
CURRENT_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
[ "$INSTALL_DIRECTORY" = "" ] && INSTALL_DIRECTORY="${CURRENT_DIRECTORY}/install"
[ "$DOTFILES_DIRECTORY" = "" ] && DOTFILES_DIRECTORY="${INSTALL_DIRECTORY}/dotfiles"
[ "$LOGS_DIRECTORY" = "" ] && LOGS_DIRECTORY="${CURRENT_DIRECTORY}/logs"
SCRIPTS_DIRECTORY="${CURRENT_DIRECTORY}/scripts"

function print_message() {
    echo -e "${BOLD}${2} ==> ${NC} ${BOLD}${1}${NORMAL}"
    log "${2}==> ${1}"
}

function print_inner_message() {
    echo -e "${BOLD}${BLUE} ->${NC} ${BOLD}${1}${NORMAL}"
    log " -> ${1}"
}

function print_error() {
    echo -e "${BOLD}${RED} ->${NC} ${BOLD}${1}${NORMAL}"
    log " -> ${1}"
    exit 1
}

function log() {
  count=0
  logfile="install.${count}.log"

  # log file already exists
  if [ -f "${LOGS_DIRECTORY}/${logfile}" ]; then
    # get it's new possible name
    while [ -f "${LOGS_DIRECTORY}/${logfile}" ]; do
        count=$(($count + 1))
        logfile="install.${count}.log"
    done

    # rename the existing file
    mv "${LOGS_DIRECTORY}/install.0.log" "${LOGS_DIRECTORY}/install.${count}.log"
    echo "${LOGS_DIRECTORY}/${logfile}"

    # reset the name
    count=0
    logfile="install.${count}.log"
  fi

  echo "${1}" >> "${LOGS_DIRECTORY}/${logfile}"
}

errors=()
function pacman_install() {
    doas pacman -S --needed --noconfirm ${1} || print_message "Could not install package: ${1}"
}

function aur_install() {
    paru -S --noconfirm --noprovides --skipreview ${1} || print_message "Could not install aur package: ${1}"
}

function flatpak_install() {
    flatpak install -y ${1} || print_error "Could not install flatpak: ${1}"
}


function enable_parallel_downloads () {
    doas sed -i '/^#\ParallelDownloads =/{N;s/#//g}' /etc/pacman.conf
}

function init_install_directory() {
    [[ -d ${INSTALL_DIRECTORY} ]] && print_error "Install directory already exist"
    mkdir -p ${INSTALL_DIRECTORY} || print_error "Unable to create the install directory"
}

function remove_install_directory() {
    [[ -d ${INSTALL_DIRECTORY} ]] && rm -rf ${INSTALL_DIRECTORY}
}

function enable_multilib () {
    doas sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf
}

function update_mirrors () {
    doas pacman -Syy --noconfirm
}

function upgrade_system () {
    doas pacman -Syu --noconfirm
}

function clear_pacman_cache () {
    doas pacman -Sc --noconfirm
}

function check_privileges() {
    if [ "$(id -u)" = 0 ]; then
        echo "####################################"
        echo "This script MUST NOT be run as root!"
        echo "####################################"
        exit 1
    fi

    doas echo ""
    [[ ${?} -eq 1 ]] && print_error "Your root password is wrong"
}

# check_privileges

# enable_parallel_downloads

# enable_multilib

# update_mirrors

# init_install_directory

# for script in "${SCRIPTS[@]}"; do
#     source "${SCRIPTS_DIRECTORY}/${script}"
# done

log "yo"

# sh "scripts/config_apps.sh"

# clear_pacman_cache

# remove_install_directory

while [ "${1:-}" != "" ]; do
  case "$1" in
    -i|--install)
      config_install
      ;;
    --no-flatpak)
      INSTALL_FLATPAK=0
      ;;
    --no-aur)
      INSTALL_AUR=0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
  shift
done
