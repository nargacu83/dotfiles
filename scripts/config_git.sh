#!/bin/bash

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

GIT_EMAIL="dev.quentinfranchi@protonmail.com"
GIT_NAME="Quentin Franchi"

PKG_GIT="git-lfs"

print_message "Configuring git"

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

sudo pacman -S --needed --noconfirm ${PKG_GIT}