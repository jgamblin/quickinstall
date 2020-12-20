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

#Install OSQuery
echo "deb [arch=amd64] https://pkg.osquery.io/deb deb main" | sudo tee /etc/apt/sources.list.d/osquery.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq update && apt-get -qq install osquery

#Install Docker
curl -L https://get.docker.com | sh
usermod -aG docker ubuntu

#Install Doecker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Install Jupyter
sudo pip3 install jupyter

# set timezone to UTC
sudo timedatectl set-timezone UTC