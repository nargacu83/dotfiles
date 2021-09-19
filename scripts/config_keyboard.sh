#!/bin/bash

# Set the keyboard layout to French

# Sourcing path is relative to install.sh
source ./globals.sh

print_message "Configuring keyboard"

sudo localectl set-keymap fr
sudo localectl set-x11-keymap fr