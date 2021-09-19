#!/bin/bash

source "common.sh"

GIT_EMAIL="dev.quentinfranchi@protonmail.com"
GIT_NAME="Quentin Franchi"

PKG_GIT="git-lfs"

print_message "Configuring git"

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

sudo pacman -S --needed --noconfirm ${PKG_GIT}