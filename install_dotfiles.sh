#!/usr/bin/env bash

# Source: https://gitlab.com/Mageas/dotfiles/-/blob/master/install.sh

#
# Variables
#
BACKUP_FOLDER="$HOME/.local/.dotfiles.backup"
SCRIPT_FOLDER="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TO_HOME_FOLDER=(.zshrc sxhkdrc)
TO_XDG_CONFIG_FOLDER=(alacritty autostart bpytop doom dunst godot gtk-3.0 gtk-4.0 lutris MangoHud mpv picom redshift rofi wallpaper zsh mimeapps.list)


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
# Install dotfiles
#
function install_dotfiles () {
    backup

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        rm -rf "$HOME/${dots_home}" &> /dev/null
        cp -rf "$SCRIPT_FOLDER/${dots_home}" "$HOME/" &> /dev/null
    done

    mkdir -p "$HOME/.config"
    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]}"; do
        rm -rf "$HOME/.config/${dots_xdg_conf[*]//./}" &> /dev/null
        cp -rf "$SCRIPT_FOLDER/.config/${dots_xdg_conf}" "$HOME/.config/${dots_xdg_conf}" &> /dev/null
    done

    echo -e "Your config is backed up in ${BACKUP_FOLDER}\n" >&2
    echo -e "Please do not delete check-backup.txt in your backup folder." >&2
    echo -e "It's used to backup and restore your old config." >&2
}


#
# Uninstall dotfiles
#
function uninstall_dotfiles () {
    if ! [[ -f "$BACKUP_FOLDER/check-backup.txt" ]]; then 
        echo "You have not installed this dotfiles yet." >&2
        exit 1
    fi

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        rm -rf "$HOME/${dots_home}" &> /dev/null
        cp -rf "$BACKUP_FOLDER/${dots_home}" "$HOME/" &> /dev/null
        rm -rf "$BACKUP_FOLDER/${dots_home}" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"; do
        rm -rf "$HOME/.config/${dots_xdg_conf}" &> /dev/null
        cp -rf "$BACKUP_FOLDER/.config/${dots_xdg_conf}" "$HOME/.config" &> /dev/null
        rm -rf "$BACKUP_FOLDER/.config/${dots_xdg_conf}" &> /dev/null
    done

    update_git_backup "Restore"
    rm -rf "$BACKUP_FOLDER/check-backup.txt" &> /dev/null

    echo "Your old config has been restored!" >&2
    echo "Thanks for using my dotfiles." >&2
    echo "Enjoy your next journey!" >&2
}


#
# Create backup
#
function backup () {
    local has_backup=True
    if ! [[ -f "$BACKUP_FOLDER/check-backup.txt" ]]; then has_backup=False; fi

    if [[ $has_backup == False ]]; then 
        mkdir -p "$BACKUP_FOLDER/.config" &> /dev/null
        cd "$BACKUP_FOLDER" || exit
        touch check-backup.txt &> /dev/null
    fi

    for dots_home in "${TO_HOME_FOLDER[@]}"; do
        if [[ $has_backup == True ]]; then 
            rm -rf "$BACKUP_FOLDER/${dots_home}" &> /dev/null
        fi
        cp -rf "$SCRIPT_FOLDER/${dots_home}" "$BACKUP_FOLDER" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"; do
        if [[ $has_backup == True ]]; then 
            rm -rf "$BACKUP_FOLDER/${dots_xdg_conf}" &> /dev/null
        fi
        cp -rf "$HOME/.config/${dots_xdg_conf}" "$BACKUP_FOLDER/.config" &> /dev/null
    done

    if [[ $has_backup == False ]]; then
        create_git_backup "Backup"
    else
        update_git_backup "Update"
    fi
}


#
# Create git backup
#
function create_git_backup () {
    if [ -x "$(command -v git)" ]; then
        cd "$BACKUP_FOLDER" || exit
        git init &> /dev/null
        update_git_backup $1
    fi
}


#
# Update git backup
#
function update_git_backup () {
    if [ -x "$(command -v git)" ]; then
        cd "$BACKUP_FOLDER" || exit
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "$1 config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
    fi
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
    --help    Print this message
    -i        Install this dotfiles
    -r        Restore your old config
EOF
}


#
# Main
#
function main () {

    anti_root

    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -i)
            install_dotfiles
            ;;
        -r)
            uninstall_dotfiles
            ;;
        *)
            echo "Invalids arguments ($@)"
            usage
            exit 1
    esac
}


main "$@"
