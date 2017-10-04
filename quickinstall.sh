#!/bin/bash
# Copyright 2016, jgamblin, released under the MIT License
# See https://github.com/jgamblin/quickinstall/blob/master/LICENSE for the
# complete license text
# Source code at https://github.com/jgamblin/quickinstall

# Upgrade installed packages to latest
echo -e "\nRunning a package upgrade...\n"
apt-get -qq update && apt-get -qq dist-upgrade


#Install stuff I use all the time
echo -e "\nInstalling default packages...\n"
apt-get -qq install build-essential checkinstall fail2ban git git-core libbz2-dev libc6-dev libgdbm-dev libncursesw5-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev nikto nmap python-dev python-numpy python-scipy python-setuptools tk-dev unattended-upgrades curl ufw
curl -L https://get.docker.com | sh

#Install and configure firewall
echo -e "\nConfiguring firewall...\n"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh

#Install NodeJS
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -qq -y nodejs


sed -i.bak 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
chmod 0644 /etc/ufw/ufw.conf

# set timezone to UTC
echo -e "\nUpdating Timezone to UTC...\n"
sudo timedatectl set-timezone UTC

#Install Ruby
echo -e "\nInstalling Ruby...\n"
apt-get -qq install gnupg2 -y
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm

#PCAP Everything
echo -e "\nRunning docker: pcap...\n"
docker run -v ~/pcap:/pcap --net=host -d jgamblin/tcpdump
