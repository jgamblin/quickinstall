#!/bin/bash

# Upgrade installed packages to latest
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq update && apt-get -qq dist-upgrade

#  Java Fixes
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:linuxuprising/java
echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selections

#Install stuff I use all the time
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq install -y \
build-essential \
curl \
jq \
nmap \
npm \
oracle-java15-installer \
oracle-java15-set-default \
python \
python-dev \
python3 \
python3-dev \
python3-dev \
python3-pip \
ruby-full \
software-properties-common \
tor \
tree \
tshark \
ufw \
unattended-upgrades \
unrar \
unzip \
wget \
wireshark 

#Install Docker
curl -L https://get.docker.com | sh
usermod -aG docker ubuntu

#Install Doecker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Install Portainer
#Change Password Right Away. 
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

#PCAP Everything
docker run -v ~/pcap:/pcap --name=PCAP --restart=always --net=host -d jgamblin/tcpdump

# set timezone to UTC
sudo timedatectl set-timezone UTC

