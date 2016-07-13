#
#Stop Asking Me Questions
#
export DEBIAN_FRONTEND=noninteractive

#
#Install and configure firewall
#
echo -e "\nInstalling and configuring firewall\n"
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh

cat /etc/ufw/ufw.conf | sed 's/ENABLED=no/ENABLED=yes/g' > ~/ufw.conf
chmod 0644 ~/ufw.conf
mv -f ~/ufw.conf /etc/ufw/ufw.conf

#
# set timezone to Universal Coordinated Time
#
sudo timedatectl set-timezone UTC

#
# Upgrade installed packages to latest
#
apt-get update && apt-get dist-upgrade -y

#
#Install stuff I use all the time
#
sudo apt-get install -y build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev python-dev python-setuptools python-numpy python-scipy nmap ntop docker.io unattended-upgrades git fail2ban

#
#PCAP Everything
#
docker run -v ~/pcap:/pcap --net=host -d jgamblin/tcpdump
