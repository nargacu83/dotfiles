#
# DON'T USE THIS SCRIPT WITHOUT CHANGING fstab
#
# Script by mageas (https://gitlab.com/Mageas) modified by Quentin Franchi
# Source : https://gitlab.com/Mageas/linux/-/blob/master/Mageas/install.sh
#

# Global variables
SCRIPT_FOLDER="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# MOUNT CONFIG
declare DISKS_TO_MOUNT_POINT=(
    "$HOME/PROJECTS"
    "$HOME/GAMES"
    "$HOME/HMM"
)
declare DISKS_TO_MOUNT=(
    "UUID=e3534ff7-8cd8-438f-80ea-e683214b9614    ${DISKS_TO_MOUNT_POINT[0]}   ext4    defaults    0 0"
    "UUID=d7bbe9d8-4f98-4d87-b26a-34c75907f71a    ${DISKS_TO_MOUNT_POINT[1]}   ext4    defaults    0 0"
    "UUID=dfefbc94-b693-4ce5-8511-72f6c837a7ec    ${DISKS_TO_MOUNT_POINT[2]}   ext4    defaults    0 0"
)

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
# Config fstab
#
function config_fstab () {
    # Create mount folders
    for _mount_point in "${DISKS_TO_MOUNT_POINT[@]}"; do
        if [ ! -d "$_mount_point" ]; then
            mkdir $_mount_point
        fi
    done
    # Config fstab
    for _disk in "${DISKS_TO_MOUNT[@]}"; do
        _sed_o=$(echo $_disk | sed -r "s/.*=([a-zA-Z0-9-]+).*/\1/")
        if grep -q $_sed_o "/etc/fstab"; then
            echo " >> Skipping $_sed_o"
        else
            echo "" | sudo tee -a /etc/fstab
            echo "# Auto from install.sh" | sudo tee -a /etc/fstab
            echo "$_disk" | sudo tee -a /etc/fstab
        fi
    done
}

#
# Main
#
function main () {
    anti_root

    config_fstab
}

main "$@"