#!/usr/bin/env bash

function _enable_reflector () {
    # Enable automatic mirrors update
    sudo systemctl enable reflector.timer
    sudo systemctl start reflector.timer

    # Update mirrors right now
    sudo systemctl start reflector.service
}


sudo pacman -S --needed --noconfirm reflector
_enable_reflector
