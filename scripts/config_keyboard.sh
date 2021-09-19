#!/bin/bash

source "common.sh"

# Set the keyboard layout to French

print_message "Configuring keyboard"

sudo localectl set-keymap fr
sudo localectl set-x11-keymap fr