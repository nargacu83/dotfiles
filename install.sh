#!/bin/bash

#
# DON'T USE THIS SCRIPT WITHOUT CHANGING fstab
#
# Modified script by Quentin Franchi, original script by mageas (https://gitlab.com/Mageas)
# Source : https://gitlab.com/Mageas/linux/-/blob/master/Mageas/install.sh
#

# Global variables
SCRIPT_FOLDER="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

GIT_EMAIL="dev.quentinfranchi@protonmail.com"
GIT_NAME="Quentin Franchi"
GRUB_RESOLUTION="2560x1080"
GRUB_OPTIONS="--boot --theme vimix --screen ultrawide"
INSTALL_FOLDER="auto_install"
NO_CONFIRM=False

# Pacman related packages for AUR
PKG_PACMAN="base-devel pacman-contrib"

# CPU & GPU drivers
PKG_DRIVERS="amd-ucode xf86-video-amdgpu xf86-video-ati mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver libva-mesa-driver mesa-vdpau lib32-mesa-vdpau"

# Display server & display manager packages
PKG_DISPLAY="xorg-server xorg-xrandr xorg-xsetroot xorg-xprop lightdm lightdm-gtk-greeter numlockx picom polkit polkit-gnome gnome-themes-extra"

# Fonts packages
PKG_FONTS="gnu-free-fonts ttf-jetbrains-mono noto-fonts-emoji ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts"

# Audio packages
PKG_AUDIO="alsa-utils alsa-oss pipewire pipewire-alsa pipewire-pulse pavucontrol"

# Terminal related packages
PKG_TERMINAL="alacritty zsh zsh-completions"

# Window manager packages
PKG_WM="qtile python"

PKG_APPS="feh rofi redshift dunst sxiv openssh firefox"

PKG_ARCHIVE="unzip unrar unace lrzip squashfs-tools"

PKG_APPS_GRAPHICS="gimp blender mpv"

PKG_APPS_GAMING="lutris steam discord"

PKG_APPS_GNOME="nautilus gvfs-smb gvfs-mtp baobab gnome-disk-utility file-roller gnome-calculator gnome-screenshot"

PKG_APPS_OFFICE="libreoffice-fresh"

PKG_YAY_APPS="pamac-aur librewolf-bin freetube-git vscodium-bin vscodium-bin-marketplace adwaita-qt"

# Development related packages
PKG_DEV="emacs ripgrep fd docker docker-compose"

# C# Support
PKG_DEV_DOTNET="dotnet-host dotnet-runtime dotnet-sdk dotnet-targeting-pack mono-msbuild"

# Java Support
PKG_DEV_JDK="jdk-openjdk jre-openjdk"

# Wine & Gaming needed packages
PKG_WINE="wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader"

#
# Set variables from args
#
function set_variables_from_args () {
    for i in "$@"; do
        case $i in
            -h|--help)
                usage
                exit 0
            ;;
            --email=*)
                GIT_EMAIL=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
            ;;
            --user=*)
                GIT_NAME=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
            ;;
            --resolution=*)
                GRUB_RESOLUTION=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
            ;;
            --noconfirm)
                NO_CONFIRM=True
            ;;
            *)
                echo "Invalids arguments ($@)"
                usage
                exit 1
            ;;
        esac
    done
}


#
# Anti ROOT
#
function anti_root () {
    if [[ $EUID -eq 0 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'
        printf "${RED}${BOLD}!! Please do not run this script as root !! \n" 1>&2
        exit 1
    fi
}


#
# Check root password
#
function check_root_password () {
    sudo echo "Correct root password !"
    if [[ $? -eq 1 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'
        printf "${RED}${BOLD}!! Your root password is wrong !! \n" 1>&2
        exit 1
    fi
}

#
# Config GIT
#
function configure_git () {
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
}


#
# Create install folder 
#
function create_install_folder () {
    cd $SCRIPT_FOLDER
    rm -rf $INSTALL_FOLDER
    mkdir $INSTALL_FOLDER
}


#
# Remove install folder 
#
function remove_install_folder () {
    cd $SCRIPT_FOLDER
    rm -rf $INSTALL_FOLDER
}


#
# Install Window Manager
#
function install_wm () {
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"

    # Packages
    sudo pacman -S --needed --noconfirm $PKG_WM

    # Install some python dependecies for qtile widgets
    pip install -y psutil
    
    # Lightdm
    sudo systemctl enable lightdm
    
    # Lightdm greeter
    sudo sed -i -e '/^#greeter-setup-script=$/s/#//g' -e 's/^greeter-setup-script=$/&\/usr\/bin\/numlockx on/g' /etc/lightdm/lightdm.conf
}

#
# Install Doom Emacs
#
function install_doom_emacs () {
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

#
# Install LibreWolf GNOME Theme
#
function install_librewolf_gnome_theme () {
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"
    git clone https://github.com/rafaelmardojai/firefox-gnome-theme/ && cd firefox-gnome-theme
    ./scripts/install.sh -f ~/.librewolf
}

#
# Install apps
#
function install_apps () {
    sudo pacman -S --needed --noconfirm $PKG_APPS
    sudo pacman -S --needed --noconfirm $PKG_APPS_GRAPHICS
    sudo pacman -S --needed --noconfirm $PKG_APPS_GAMING
    sudo pacman -S --needed --noconfirm $PKG_ARCHIVE
    sudo pacman -S --needed --noconfirm $PKG_APPS_GNOME
    sudo pacman -S --needed --noconfirm $PKG_APPS_OFFICE
}

#
# Install developement apps
#
function install_dev () {
    sudo pacman -S --needed --noconfirm $PKG_DEV
    sudo pacman -S --needed --noconfirm $PKG_DEV_DOTNET
    sudo pacman -S --needed --noconfirm $PKG_DEV_JDK
}

#
# Install WINE
#
function install_wine () {
    sudo pacman -S --needed --noconfirm $PKG_WINE
}

#
# Install drivers, fonts, audio, terminal
#
function install_base () {
    sudo pacman -S --needed --noconfirm $PKG_PACMAN
    sudo pacman -S --needed --noconfirm $PKG_DRIVERS
    sudo pacman -S --needed --noconfirm $PKG_DISPLAY
    sudo pacman -S --needed --noconfirm $PKG_FONTS
    sudo pacman -S --needed --noconfirm $PKG_AUDIO
    sudo pacman -S --needed --noconfirm $PKG_TERMINAL
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

#
# Install dotfiles
#
function install_dotfiles () {
    sudo mkdir /usr/share/xsessions
    "$SCRIPT_FOLDER/install_dotfiles.sh" -i
    sh "$SCRIPT_FOLDER/root/install_root.sh"
}

function install_non_official_repository_apps () {
    _install_yay

    _install_yay_apps

    _install_custom_grub

    _install_spaceship
}

function _install_yay () {
    cd ${INSTALL_FOLDER}
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --needed
}
function _install_yay_apps () {
    yay -S --noconfirm $PKG_YAY_APPS
}
function _install_custom_grub () {
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"
    sudo sed -i -e "s/GRUB_GFXMODE=auto/GRUB_GFXMODE=$GRUB_RESOLUTION,auto/g" /etc/default/grub
    git clone https://github.com/vinceliuice/grub2-themes
    cd grub2-themes
    sudo ./install.sh $GRUB_OPTIONS
}
function _install_spaceship () {
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"
    # Clone and build Spaceship
    git clone https://aur.archlinux.org/spaceship-prompt-git.git --depth=1
    cd spaceship-prompt-git
    makepkg -si --noconfirm --needed
    cd "$SCRIPT_FOLDER/$INSTALL_FOLDER"
    mkdir $HOME/.cache
    mkdir $HOME/.cache/zsh
}


#
# Enable pacman multilib
#
function enable_multilib () {
    sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf
}

#
# Set the french azerty layout for the keyboard
#
function set_keyboard_layout () {
    sudo localectl set-keymap fr-latin1
    sudo localectl set-x11-keymap fr
}

function config_fstab () {
    sh "$SCRIPT_FOLDER/config_fstab.sh"
}

function install_lts_kernel () {
    sudo pacman -S --needed --noconfirm linux-lts
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

# 
# Do not boot on LTS 
# 
function change_boot_order () {
    local grub_boot_list=$(sudo grep gnulinux /boot/grub/grub.cfg)
    local grub_submenu=$(echo $grub_boot_list | sed -r "s/^.*(gnulinux-advanced-[a-zA-Z0-9-]*).*/\1/")
    local grub_arch=$(echo $grub_boot_list | sed -r "s/^.*(gnulinux-linux-advanced-[a-zA-Z0-9-]*).*/\1/")
    local grub_boot="GRUB_DEFAULT=\"$grub_submenu>$grub_arch\""
    sudo sed -i -r "s/^GRUB_DEFAULT=0/#GRUB_DEFAULT=0\n$grub_boot/" /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

#
# Change shell to ZSH
#
function change_shell_to_zsh () {
    chsh -s /bin/zsh
}

function update_mirrors () {
    sudo pacman -Syy --noconfirm
}

function upgrade_system () {
    sudo pacman -Syu --noconfirm
}

function clear_pacman_cache () {
    sudo pacman -Sc --noconfirm
}

#
# Usage
#
usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]
Options:
    --email=[..]         Set your gitlab email
    --name=[..]          Set your gitlab name
    --resolution[..x..]  Set your grub resolution
    --noconfirm          Erase files if exist without confirmation
EOF
}


#
# Main
#
function main () {
    anti_root

    set_variables_from_args "$@"

    enable_multilib

    update_mirrors

    check_root_password

    create_install_folder

    configure_git

    install_base

    install_wm

    install_apps

    install_dev

    install_wine
    
    install_non_official_repository_apps

    upgrade_system

    config_fstab

    install_lts_kernel

    change_boot_order

    set_keyboard_layout
    
    install_dotfiles

    remove_install_folder

    change_shell_to_zsh

    clear_pacman_cache
}


main "$@"
