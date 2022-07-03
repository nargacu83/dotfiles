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
[ "$CONFIG_DIRECTORY" = "" ] && CONFIG_DIRECTORY="${CURRENT_DIRECTORY}/config"
[ "$DOTFILES_DIRECTORY" = "" ] && DOTFILES_DIRECTORY="${INSTALL_DIRECTORY}/dotfiles"
[ "$LOGS_DIRECTORY" = "" ] && LOGS_DIRECTORY="${CURRENT_DIRECTORY}/logs"
SCRIPTS_DIRECTORY="${CURRENT_DIRECTORY}/scripts"

errors=()

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
  # if [ -f "${LOGS_DIRECTORY}/${logfile}" ]; then
  #   # get it's new possible name
  #   while [ -f "${LOGS_DIRECTORY}/${logfile}" ]; do
  #       count=$(($count + 1))
  #       logfile="install.${count}.log"
  #   done

  #   # rename the existing file
  #   mv "${LOGS_DIRECTORY}/install.0.log" "${LOGS_DIRECTORY}/install.${count}.log"

  #   # reset the name
  #   count=0
  #   logfile="install.${count}.log"
  # fi

  echo "${1}" >> "${LOGS_DIRECTORY}/${logfile}"
}

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

function check_config() {
  # Get all config files
  configs=()
  for file in "${CONFIG_DIRECTORY}"/*; do
      configs+=($(basename $file))
  done

  # Check if there are config files
  if [ ${#configs[@]} -eq 0 ]; then
    print_error "No configs detected"
    exit 1
  fi

  # Check if selected config was not given
  if [ "$SELECTED_CONFIG" == "" ]; then
    SELECTED_CONFIG="default"
  fi

  # Check if the given configuration file name exists
  valid=0
  for config in "${configs[@]}"; do
    if [ "$SELECTED_CONFIG" == "$config" ]; then
      valid=1
    fi
  done
  if [ $valid -eq 0 ]; then
    print_error "Configuration file \"$SELECTED_CONFIG\" not found"
    exit 1
  fi
}

usage()
{
    echo "Usage: $0 [args]"
    echo "Args:"
    echo "--config <config_name>"
    echo "--no-flatpak"
    echo "--no-aur"
    echo "--no-multilib"
    echo "--parallel"
}

args=()
while [ "${1:-}" != "" ]; do
  args+=("${1:-}")
  shift
done

for i in "${!args[@]}"; do
  arg=${args[$i]}
  case $arg in
    --config)
      SELECTED_CONFIG=${args[$(($i + 1))]}
      ;;
    --no-flatpak)
      INSTALL_FLATPAK=0
      ;;
    --no-aur)
      INSTALL_AUR=0
      ;;
    --no-multilib)
      ENABLE_MULTILIB=0
      ;;
    --parallel)
      PARALLEL_DOWNLOADS=${args[$(($i + 1))]}
      if ! [[ $PARALLEL_DOWNLOADS =~ '^[0-9]+$' ]] ; then
        PARALLEL_DOWNLOADS=0
        print_error "Invalid argument for PARALLEL_DOWNLOADS"
        exit 1
      fi
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# check_privileges

check_config

# enable_parallel_downloads

# enable_multilib

# update_mirrors

# init_install_directory

# source "${SCRIPTS_DIRECTORY}/config_fstab"

# for script in "${SCRIPTS[@]}"; do
#     source "${SCRIPTS_DIRECTORY}/${script}"
# done

# clear_pacman_cache

# remove_install_directory
