#!/bin/bash

# System and dotfiles packages

source "../install.sh"

# Pacman related packages for AUR
PKG_PACMAN="
base-devel
pacman-contrib
"

# CPU & GPU drivers
PKG_DRIVERS="
amd-ucode
xf86-video-amdgpu
xf86-video-ati
mesa lib32-mesa
vulkan-radeon
lib32-vulkan-radeon
libva-mesa-driver
lib32-libva-mesa-driver
libva-mesa-driver
mesa-vdpau
lib32-mesa-vdpau
"

# Display server & display manager packages
PKG_DISPLAY="
xorg-server
xorg-xrandr
xorg-xsetroot
xorg-xprop
numlockx
xcb-util-cursor
picom
"

PKG_LIGHTDM="
lightdm
lightdm-gtk-greeter
"

PKG_POLKIT="
polkit
polkit-gnome
"

PKG_THEMES="
gnome-themes-extra
"

# Fonts packages
PKG_FONTS="
gnu-free-fonts
ttf-jetbrains-mono
noto-fonts-emoji
ttf-bitstream-vera
ttf-croscore
ttf-dejavu
ttf-droid
ttf-ibm-plex
ttf-liberation
ttf-linux-libertine
noto-fonts
"

# Audio packages
PKG_AUDIO="
alsa-utils
alsa-oss
pipewire
pipewire-alsa
pipewire-pulse
pavucontrol
"

# Network management
PKG_NETWORK="
nm-connection-editor
"

# Printer drivers and management
PKG_PRINTER="
cups cups-filters
cups-pdf
ghostscript
gsfonts
foomatic-db-engine
foomatic-db
foomatic-db-ppds
foomatic-db-nonfree
foomatic-db-nonfree-ppds
gutenprint
foomatic-db-gutenprint-ppds
splix system-config-printer
hplip python-pyqt5
python-reportlab
xsane
"

# Archive
PKG_ARCHIVE="
unzip
unrar
unace
lrzip
squashfs-tools
"

# Terminal related packages
PKG_TERMINAL="
alacritty
zsh
zsh-completions
"

PKG_DOTFILES="
stow
"

function _install_spaceship () {
    cd ${INSTALL_DIRECTORY}
    # Clone and build Spaceship
    git clone https://aur.archlinux.org/spaceship-prompt-git.git --depth=1 ${INSTALL_DIRECTORY}
    cd "${INSTALL_DIRECTORY}/spaceship-prompt-git"
    makepkg -si --noconfirm --needed
    mkdir -p ${HOME}/.cache/zsh
}

print_message "Configuring system"

sudo pacman -S --needed --noconfirm ${PKG_PACMAN}
sudo pacman -S --needed --noconfirm ${PKG_DRIVERS}
sudo pacman -S --needed --noconfirm ${PKG_DISPLAY}
sudo pacman -S --needed --noconfirm ${PKG_LIGHTDM}
sudo pacman -S --needed --noconfirm ${PKG_POLKIT}
sudo pacman -S --needed --noconfirm ${PKG_THEMES}
sudo pacman -S --needed --noconfirm ${PKG_FONTS}
sudo pacman -S --needed --noconfirm ${PKG_AUDIO}
sudo pacman -S --needed --noconfirm ${PKG_NETWORK}

sudo pacman -S --needed --noconfirm ${PKG_PRINTER}
sudo systemctl enable cups

sudo pacman -S --needed --noconfirm ${PKG_TERMINAL}
_install_spaceship
sudo chsh -s /bin/zsh ${USER}

sudo grub-mkconfig -o /boot/grub/grub.cfg