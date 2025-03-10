# Ubuntu Perforce server setup script

This bash script will setup Perforce a good 90% of the way. Running all the commands you need to run it. Making it nice and easy to get setup and working.

## Why?

I had a few clients who wanted it setup and it was the same commands over and over again, so a quick bash script and now its easier than ever.

## Limitations
- Ubuntu based only - I tried to get it working on Debian what I normally use but either packages weren't available or they were out of date. Without a lot of messing around updating sources its just easier to use Ubuntu for now.

- Randomly sometimes the script will just stop running. No idea why. You can try to view the last thing it ran then re-run from there. If you can let me know WHICH bit it stopped on, I can try to fix.

## 🛠️ Installation Steps - development

Video:
https://youtu.be/P8DKbF6aQfk

1) Clone the repo / download the `perforce_server_setup.sh`

```bash
git clone https://github.com/d3kryption/ubuntu_perforce_server_setup
```

2) Move the bash file onto your server and run it as sudo.

```bash
sudo ./perforce_server_setup.sh
```

3) Some steps will pause execution and wait for you to enter some details to continue.

NOTE: The newest version of the script automates the Typemap part! 

Keeping this here for anyone who wants the changes. (You don't need to do this)

4) Remove the following lines: (see p4TypemapRemoval.md for a easier list)

```bash
binary+l //....exe
binary+l //....dll
binary+l //....lib
binary+l //...bmp
binary+l //...tar
```

5) Paste these typemap settings in when prompted (see p4TypemapAdditions.md for a easier list)
```bash
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
```

## Upgrade / Reboot issue

In version **2024.1**, a fatal bug causes P4 to stop working when you UPDATE / UPGRADE. It can be resolved with the below steps.

1) Modify the file `nano /etc/perforce/p4dctl.conf.d/master.conf`

2) You need to add the lines above **P4ROOT**:
`P4PORT = SSL:YOUR IP ADDRESS:1666`
`P4LOG = /var/log/perforce/p4err`
`P4SSLDIR = /mnt/YOUR STORAGE LOCATION/root/ssl`

3) Press CTRL+X to exit, Y to save, and then enter

4) Now reboot the Perforce service: `systemctl start helix-p4dctl.service` and then Perforce: `p4 admin restart`
