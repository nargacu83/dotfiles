#!/bin/bash

# Installs development related packages

# Sourcing path is relative to install.sh
source ./globals.sh

# Game Engine
PKG_ENGINE="godot scons"

# Editors
PKG_EDITORS="emacs ripgrep fd"

# Docker
PKG_DEV_DOCKER="docker docker-compose"

# C# Support
PKG_DEV_DOTNET="dotnet-host dotnet-runtime dotnet-sdk dotnet-targeting-pack mono-msbuild"

# Java Support
PKG_DEV_JDK="jdk-openjdk jre-openjdk"

print_message "Configuring developement"

sudo pacman -S --needed --noconfirm ${PKG_ENGINE}
sudo pacman -S --needed --noconfirm ${PKG_EDITORS}
sudo pacman -S --needed --noconfirm ${PKG_DEV_DOCKER}
sudo pacman -S --needed --noconfirm ${PKG_DEV_DOTNET}
sudo pacman -S --needed --noconfirm ${PKG_DEV_JDK}