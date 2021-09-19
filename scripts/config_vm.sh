#!/bin/bash

# Installs Virtual Machine packages

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_VM="
qemu
libvirt
edk2-ovmf
virt-manager
dnsmasq
"

# TODO: Need to fix a little conflict
PKG_TEMP="ebtables"

print_message "Configuring Virtual Machine"

sudo pacman -S --needed --noconfirm ${PKG_VM}
sudo pacman -S --needed --noconfirm ${PKG_TEMP}
systemctl enable --now libvirtd
virsh net-start default
virsh net-autostart default
usermod -aG kvm,input,libvirt quentin