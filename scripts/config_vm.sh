#!/bin/bash

# Installs Virtual Machine packages

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

PKG_VM="
qemu
libvirt
edk2-ovmf
virt-manager
dnsmasq
ebtables
"

print_message "Configuring Virtual Machine"

sudo pacman -S --needed --noconfirm ${PKG_VM}
systemctl enable --now libvirtd
virsh net-start default
virsh net-autostart default
usermod -aG kvm,input,libvirt quentin