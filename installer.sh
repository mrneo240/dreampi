#!/bin/sh

# install prereqs
sudo apt install dnsmasq dnsutils libnetfilter-queue-dev libnetfilter-queue1 ppp arping nftables tcpd wvdial git

# grab files
git clone https://github.com/mrneo240/dreampi.git
cd dreampi

# install packages
sudo dpkg -i arm/*.deb

# copy files to /usr
mkdir -p /usr/local/share/dreampi
cp *.py dial-tone.wav /usr/local/share/dreampi
ln -s /usr/local/share/dreampi/dreampi.py /usr/local/bin/dreampi
chown -R root:root /usr/local/share/dreampi/

#Activate scripts used to launch system services:
cp etc/init.d/dreampi /etc/init.d/
cp etc/systemd/system/dreampi.service /etc/systemd/system/

# write dnsmasq config
cat >> /etc/dnsmasq.d/dreampi.conf<< EOF
domain-needed
bogus-priv
server=46.101.91.123
no-resolv
no-hosts
cache-size=500
log-queries
EOF

# dreampi --no-daemon
