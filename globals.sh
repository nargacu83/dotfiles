#!/bin/bash

# Common functions and variables

# Global variables
FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
INSTALL_DIRECTORY="$(dirname "$FILE_DIRECTORY")/.dotfiles"

inc=1
function print_message() {
    for i in $(seq 1 $((${#1}+14))); do echo -n "#"; done; echo
    echo "## ($(printf "%02d" ${inc})/$(printf "%02d" ${number_of_steps})) ${1} ##"; inc=$((${inc}+1))
    for i in $(seq 1 $((${#1}+14))); do echo -n "#"; done; echo
}

function print_error() {
    echo -e "\033[0;31m\033[1m!! $1 !! \033[0m\n"
    exit 1
}