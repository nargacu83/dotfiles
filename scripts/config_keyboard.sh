#!/bin/bash

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

# Set the keyboard layout to French

print_message "Configuring keyboard"

sudo localectl set-keymap fr
sudo localectl set-x11-keymap fr