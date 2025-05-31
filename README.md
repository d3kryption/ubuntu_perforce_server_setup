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

## Upgrade / Reboot issue

In version **2024.1**, a fatal bug causes P4 to stop working when you UPDATE / UPGRADE. It can be resolved with the below steps.

1) Modify the file `nano /etc/perforce/p4dctl.conf.d/master.conf`

2) You need to add the lines above **P4ROOT**:
`P4PORT = SSL:YOUR IP ADDRESS:1666`
`P4LOG = /var/log/perforce/p4err`
`P4SSLDIR = /mnt/YOUR STORAGE LOCATION/root/ssl`

3) Press CTRL+X to exit, Y to save, and then enter

4) Now upgrade the Perforce DB `sudo -u perforce /opt/perforce/sbin/p4d -r YOUR PERFORCE LOCATION/master/root -xu` e.g. `sudo -u perforce /opt/perforce/sbin/p4d -r /mnt/MyDrive/Perforce/master/root -xu`

5) Now reboot the Perforce service: `systemctl start helix-p4dctl.service` and then Perforce: `p4 admin restart`
