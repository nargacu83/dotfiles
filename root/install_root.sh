#!/bin/bash

# Source: https://gitlab.com/Mageas/dotfiles/-/blob/master/root/install_root.sh

#
# Variables
#
SCRIPT_FOLDER="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
NO_CONFIRM=False


#
# Set variables from args
#
function set_variables_from_args () {
    case "$1" in
        --noconfirm)
            NO_CONFIRM=True
        ;;
        *)
            
        ;;
    esac
}


#
# Anti ROOT
#
function anti_root () {
    if [[ $EUID -eq 0 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'
        printf "${RED}${BOLD}!! Please do not run this script as root !! \n" 1>&2
        exit 1
    fi
}


#
# Check root password
#
function check_root_password () {
    sudo echo "Correct root password !"
    if [[ $? -eq 1 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'
        printf "${RED}${BOLD}!! Your root password is wrong !! \n" 1>&2
        exit 1
    fi
}


#
# List files
#
function list_files () {
    cd $SCRIPT_FOLDER
    echo $(find . -type f)
}


#
# Copy files
#
function copy_files () {
    cd $SCRIPT_FOLDER
    delimiter="./"
    conCatString=$*$delimiter
    splitMultiChar=()
    while [[ $conCatString ]]; do
        splitMultiChar+=( "${conCatString%%"$delimiter"*}" )
        conCatString=${conCatString#*"$delimiter"}
    done

    for file in "${splitMultiChar[@]}"; do
        file=$(echo $file|tr -d '\n')
        if [[ "$file" != "" && "$file" != "install_root.sh" ]]; then
            printf "\n./$file --> /$file\n"
            if [[ $NO_CONFIRM == True ]]; then
                sudo cp "./$file" "/$file"
            else
                sudo cp -i "./$file" "/$file"
            fi
        fi
    done
}


#
# Main
#
function main () {
    anti_root

    check_root_password

    set_variables_from_args "$@"

    files=$(list_files)

    copy_files $files
}


main "$@"