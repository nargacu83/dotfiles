#!/bin/bash

# Sourcing path is relative to install.sh
source ./globals.sh

print_message "Configuring LightDM"

 # Enable Lightdm
sudo systemctl enable lightdm
# Lightdm greeter
sudo sed -i -e '/^#greeter-setup-script=$/s/#//g' -e 's/^greeter-setup-script=$/&\/usr\/bin\/numlockx on/g' /etc/lightdm/lightdm.conf