#!/bin/bash

# Be sure to read the README before doing anything!!!!!!!!!

# Root Check!!!!!!!!

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


# Case statements that (hopefully) make this stage foolproof.
echo -e "
Please enter the name of the user to create: \c"
read username

case $username in
  "")
  echo "Invalid username. Exiting..."
  exit
  ;;
  * )
  ;;
esac

while true; do
echo -e "
Please enter the groups you would like the user to be in. (No spaces, separated by commas): \c"
read groups

case "$groups" in
  *\ * )
    echo "
Oops! A space was detected. Try again without spaces."
    ;;
  *,* )
  break
    ;;
  * )
    echo "
Weird format detected. Either you only wanted one group, messed up badly, or forgot commas."
  while true; do
    echo -e "
Continue anyway? [y/n] \c"
    read yn
  case $yn in
        [Yy]* )
        break
        ;;
        [Nn]* )
        exit
        ;;
        * )
        echo "Please answer either y (yes) or n (no)"
        ;;
    esac
  done
  break
    ;;
esac
done

useradd -m -G $groups $username

# I should make the above code a utility for linux beginners. Maybe someday.


# Funny line and start of the actual process of downloading dwm and stuff. (These are the lines you'd probably want to edit for compatibility and customization)


cd /home/$username
mkdir work
mkdir ez-dwm-out

echo "Downloading dependencies, this may take a while..."

pacman --noconfirm -Sy git xorg-server xorg-xrandr xorg-xinit wget base base-devel

# Don't edit those packages unless you know what you are doing!!!!!!!!!

echo -e "
Use git to download dwm, st and dmenu? (This will make patching and adding modifications easier) [y/n] \c"
read yntwo
case $yntwo in
   [Yy]* )
   echo "Downloading through git..."
   
   cd ez-dwm-out
   
   echo -e "
Please enter an email for git: \c"
   read email
   echo -e "Please enter a username for git: \c"
   read gituser
   
   git config --global user.email $email
   git config --global user.name $gituser
   
   git clone https://git.suckless.org/dwm
   git clone https://git.suckless.org/st
   git clone https://git.suckless.org/dmenu
   
   cd dwm
   make clean install
   
   cd ../st
   make clean install
   
   cd ../dmenu
   make clean install
   
   cd ..
   rm -rf work
   (echo "exec dwm") | sed '1w .xinitrc'
   
   
   ;;
   [Nn]* ) 
   echo "Downloading via wget..."
   
   cd work
   wget https://dl.suckless.org/dwm/dwm-6.3.tar.gz
   wget https://dl.suckless.org/st/st-0.8.5.tar.gz
   wget https://dl.suckless.org/tools/dmenu-5.1.tar.gz
   
   cd ../ez-dwm-out
   tar -xzf ../work/dwm-6.3.tar.gz
   tar -xzf ../work/st-0.8.5.tar.gz
   tar -xzf ../work/dmenu-5.1.tar.gz
   
   cd dwm-6.3
   make clean install
   
   cd ../st-0.8.5
   make clean install
   
   cd ../dmenu-5.1
   make clean install
   
   cd ..
   rm -rf work
   (echo "exec dwm") | sed '1w .xinitrc'
   ;;
   * )
   echo "Please answer either y (yes) or n (no)"
   ;;
esac


echo -e "Be sure to reboot and login as the user you just created. Hit enter/return to make a password for the newly created user and to exit this script. \c"
read

passwd $username

exit
# Just in case passwd doesn't exit for some reason






















# alex is hot
