#!/bin/bash

apt -y update; apt -y upgrade;

# installs
apt install ufw gpg;

# firewall setup
ufw default deny incoming;
ufw default allow outgoing;
ufw allow ssh;
ufw allow http;
ufw allow https;

# perforce
wget https://package.perforce.com/perforce.pubkey;

gpg -n --import --import-options import-show perforce.pubkey

wget -qO - https://package.perforce.com/perforce.pubkey | sudo apt-key add -;

# Add perforce repo
cat > /etc/apt/sources.list.d/perforce.list << EOF
deb http://package.perforce.com/apt/ubuntu focal release
EOF

# update with new repo
apt -y update;

# install perforce
apt install -y helix-p4d;

# perforce settings
echo "export EDITOR='nano'" >> ~/.bashrc
echo "export VISUAL='nano'" >> ~/.bashrc

# refresh bashrc
source ~/.bashrc

# perforce config setup
sudo /opt/perforce/sbin/configure-helix-p4d.sh

# configure set security settings
p4 configure set net.rfc3484=1
p4 configure set dm.user.noautocreate=2
p4 configure set run.users.authorize=1

# set ignore file
p4 set P4IGNORE=.p4ignore

# firewall
echo "press Y to allow firewall"

# allow perforce
ufw allow 1666;

# enable firewall
ufw enable

# final typemap settings
p4 typemap;
