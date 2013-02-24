#!/bin/bash
# Some parts of this script has been inspired from Kord Campbell's OpenStack installation
# scripts available at https://github.com/StackGeek/openstackgeek

# Make sure only root can run your script
if [ "$(id -u)" != "0" ]; then
  echo "You need to be 'root' dude." 1>&2
  exit 1
fi

# Update and upgrade ubuntu
echo "updating your system"
apt-get update
echo "upgrading your system"
apt-get upgrade

# Prompting for reboot
while true; do
    read -p "System needs to reboot. Reboot?" yn
    case $yn in
        [Yy]* ) reboot now; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

exit
