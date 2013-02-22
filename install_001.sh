#!/bin/bash
# Some parts of this script has been inspired from Kord Campbell's OpenStack installation
# scripts available at https://github.com/StackGeek/openstackgeek

# Make sure only root can run your script
if [ "$(id -u)" != "0" ]; then
  echo "You need to be 'root' dude." 1>&2
  exit 1
fi

# Install pre-requisites
sudo apt-get install aptitude
sudo aptitude install ntp
service ntp restart
sudo aptitude install -y build-essential subversion libncurses5-dev libssl-dev libxml2-dev libsqlite3-dev uuid-dev vim-nox

# Lot more to add here

exit
