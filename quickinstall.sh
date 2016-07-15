#!/bin/bash
# Copyright 2016, jgamblin, released under the MIT License 
# See https://github.com/jgamblin/quickinstall/blob/master/LICENSE for the
# complete license text
# Source code at https://github.com/jgamblin/quickinstall

# Upgrade installed packages to latest
echo -e "\nRunning a package upgrade...\n"
apt-get -qq -y update && apt-get -qq -y dist-upgrade


#Install stuff I use all the time
echo -e "\nInstalling default packages...\n"
apt-get -qq -y install build-essential checkinstall docker.io fail2ban git git-core libbz2-dev libc6-dev libgdbm-dev libncursesw5-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev nikto nmap nodejs python-dev python-numpy python-scipy python-setuptools tk-dev unattended-upgrades ufw


#Install and configure firewall
echo -e "\nConfiguring firewall...\n"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh

sed -i.bak 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
chmod 0644 /etc/ufw/ufw.conf

# set timezone to UTC
echo -e "\nUpdating Timezone to UTC...\n"
sudo timedatectl set-timezone UTC

#Install Ruby
echo -e "\nInstalling Ruby...\n"
curl -L https://get.rvm.io | bash -s stable --ruby

#PCAP Everything
echo -e "\nRunning docker: pcap...\n"
docker run -v ~/pcap:/pcap --net=host -d jgamblin/tcpdump
