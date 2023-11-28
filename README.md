# Ubuntu Perforce server setup script

This bash script will setup Perforce a good 90% of the way. Running all the commands you need to run it. Making it nice and easy to get setup and working.

## Why?

I had a few clients who wanted it setup and it was the same commands over and over again, so a quick bash script and now its easier than ever.

## Limitations
- Ubuntu based only - I tried to get it working on Debian what I normally use but either packages weren't available or they were out of date. Without a lot of messing around updating sources its just easier to use Ubuntu for now.

## 🛠️ Installation Steps - development

1) Clone the repo / download the `perforce_server_setup.sh`

```bash
git clone https://github.com/d3kryption/ubuntu_perforce_server_setup
```

2) Move the bash file onto your server and run it as sudo.

```bash
sudo ./perforce_server_setup.sh
```

3) Some steps will pause execution and wait for you to enter some details to continue.

