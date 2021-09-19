#!/bin/bash

# Installs Long Term Support kernel

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

# Do not boot on LTS 
function change_boot_order () {
    local grub_boot_list=$(sudo grep gnulinux /boot/grub/grub.cfg)
    local grub_submenu=$(echo $grub_boot_list | sed -r "s/^.*(gnulinux-advanced-[a-zA-Z0-9-]*).*/\1/")
    local grub_arch=$(echo $grub_boot_list | sed -r "s/^.*(gnulinux-linux-advanced-[a-zA-Z0-9-]*).*/\1/")
    local grub_boot="GRUB_DEFAULT=\"$grub_submenu>$grub_arch\""
    sudo sed -i -r "s/^GRUB_DEFAULT=0/#GRUB_DEFAULT=0\n$grub_boot/" /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

print_message "Configuring LTS"

sudo pacman -S --needed --noconfirm linux-lts
sudo grub-mkconfig -o /boot/grub/grub.cfg
change_boot_order