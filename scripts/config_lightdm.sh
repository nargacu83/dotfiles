#!/bin/bash

FILE_DIRECTORY="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_SCRIPT="$(dirname "$FILE_DIRECTORY")/install.sh"
source ${BASE_SCRIPT}

print_message "Configuring LightDM"

 # Enable Lightdm
sudo systemctl enable lightdm
# Lightdm greeter
sudo sed -i -e '/^#greeter-setup-script=$/s/#//g' -e 's/^greeter-setup-script=$/&\/usr\/bin\/numlockx on/g' /etc/lightdm/lightdm.conf