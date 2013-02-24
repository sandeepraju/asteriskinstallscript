#!/bin/bash

# Make sure only root can run your script
if [ "$(id -u)" != "0" ]; then
  echo "You need to be 'root' dude." 1>&2
  exit 1
fi

# Install pre-requisites
apt-get install aptitude
aptitude install ntp
service ntp restart
aptitude install -y build-essential subversion libncurses5-dev libssl-dev libxml2-dev libsqlite3-dev uuid-dev vim-nox axel libnewt-dev

echo "Creating directory for source  ~/src/asterisk-complete/asterisk"
mkdir -p ~/src/asterisk-complete/asterisk
cd  ~/src/asterisk-complete/asterisk

echo "Downloading current version of asterisk source "
axel -n10 http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11-current.tar.gz
tar -xzf asterisk-11-current.tar.gz
mv asterisk-11.* asterisk-current
echo "Downloading the current version of libPRI source"
axel -n10 http://downloads.asterisk.org/pub/telephony/libpri/libpri-1.4-current.tar.gz
tar -xzf libpri-1.4-current.tar.gz
echo "Downloading the current version of DAHDI source"
tar -xzf dahdi-linux-complete-current.tar.gz

echo "Installing DAHDI modules"
apt-get install linux-headers-`uname -r`
cd dahdi*
make all
make install
make config

echo "Installing LibPRI modules"
cd ../libpri*
make install

echo "DAHDI and LibPRI successfully installed !"

echo "Installing asterisk !"
cd ../asterisk-current/
./configure
make
make install
make config

chown -R asteriskpbx:asteriskpbx /var/lib/asterisk/
chown -R asteriskpbx:asteriskpbx /var/spool/asterisk/
chown -R asteriskpbx:asteriskpbx /var/log/asterisk/
chown -R asteriskpbx:asteriskpbx /var/run/asterisk

echo "Creating path /etc/asterisk"
mkdir -p /etc/asterisk/
chown asteriskpbx:asteriskpbx /etc/asterisk/
exit
