# ez-dwm

An easy way to install dwm and other suckless tools right after installing Arch Linux.

## Info

Basically just installs some xorg packages, sets up dwm, st, and dmenu. There is also a little thing that makes adding users easier.

I got really bored of having to do these steps over and over again, so this just automates the process.

## Install

Make sure you are using the bash shell and are on Arch Linux.

This is intended to be run right after a fresh installation, so make sure you have sudo set up. Follow [this article](https://wiki.archlinux.org/title/sudo#Using_visudo) and configure sudo according to the "Example Entries" section to your liking.

To get going, git clone the this repository:

    git clone https://github.com/blzby1/ez-dwm.git
    
Make main.sh executable:

    chmod +x ez-dwm/main.sh

Execute ``ez-dwm/main.sh``, follow the directions onscreen, and enjoy!

## Notes and Warnings

This script is pretty "stupid" and can't really pick out that many errors. There are some safeguards in place, but they are very minimal. If you encounter a bug, be sure to open an issue so that the bug can be resolved.

Also, just in case you didn't know how to, you can start dwm with the command ``startx`` (since this script uses xinitrc)
