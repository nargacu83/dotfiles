#!/bin/bash

# Installs Virtual Machine packages

source "common.sh"

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