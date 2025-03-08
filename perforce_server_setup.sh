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

wget -qO - https://package.perforce.com/perforce.pubkey | gpg --dearmor | sudo tee /usr/share/keyrings/perforce-archive-keyring.gpg > /dev/null

# Add perforce repo
cat > /etc/apt/sources.list.d/perforce.list << EOF
deb [signed-by=/usr/share/keyrings/perforce-archive-keyring.gpg] http://package.perforce.com/apt/ubuntu focal release
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

# final typemap settings
#p4 typemap;

# File to store the existing typemap
TEMP_FILE="current_typemap.txt"

# Fetch the existing typemap and save it to a file
p4 typemap -o > "$TEMP_FILE"

# Remove specific lines
sed -i '/binary\+l \/\/\.\.\.\(exe\|dll\|lib\|bmp\|tar\)/d' "$TEMP_FILE"

# Append custom typemap rules to the end of the file
cat <<EOL >> "$TEMP_FILE"
    binary+w //....exe
    binary+w //....dll
    binary+w //....lib
    binary+w //....app
    binary+w //....dylib
    binary+w //....stub
    binary+w //....ipa
    binary //....bmp
    text //....ini
    text //....config
    text //....cpp
    text //....h
    text //....c
    text //....cs
    text //....m
    text //....mm
    text //....py
    binary+l //....uasset
    binary+l //....umap
    binary+l //....upk
    binary+l //....udk
    binary+l //....ubulk
    binary+wS //..._BuiltData.uasset
EOL

# Re-import the updated typemap
p4 typemap -i < "$TEMP_FILE"

# Cleanup
rm "$TEMP_FILE"

echo "Typemap updated successfully."

# firewall

# allow perforce
ufw allow 1666;

# enable firewall
echo "y" | ufw enable
