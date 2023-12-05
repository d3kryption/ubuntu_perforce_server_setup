# Ubuntu Perforce server setup script

This bash script will setup Perforce a good 90% of the way. Running all the commands you need to run it. Making it nice and easy to get setup and working.

## Why?

I had a few clients who wanted it setup and it was the same commands over and over again, so a quick bash script and now its easier than ever.

## Limitations
- Ubuntu based only - I tried to get it working on Debian what I normally use but either packages weren't available or they were out of date. Without a lot of messing around updating sources its just easier to use Ubuntu for now.

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

4) Paste these typemap settings in when prompted
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
