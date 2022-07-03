#!/bin/bash

# Sourcing path is relative to install.sh
source ./globals.sh

GIT_EMAIL="dev.quentinfranchi@protonmail.com"
GIT_NAME="Quentin Franchi"

print_message "Configuring git"

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
