#!/bin/bash

# Installs Virtual Machine packages

# Sourcing path is relative to install.sh
source ./globals.sh

PKG_VM="
qemu-full
libvirt
edk2-ovmf
virt-manager
dnsmasq
ebtables
"

print_message "Configuring Virtual Machine"

sudo pacman -Rns iptables
sudo pacman -S --needed --noconfirm ${PKG_VM}
sudo systemctl enable --now libvirtd
sudo virsh net-start default
sudo virsh net-autostart default
sudo usermod -aG kvm,input,libvirt quentin
