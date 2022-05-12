#!/bin/bash

# If you somehow don't have bash, please install it. It's a little something guys like me in the tech world call a "dependency"
# Also, if you get a "command not found" error somehow, then please install that using "sudo pacman -S (command, or package that contains it)"
# No, I don't know why I'm making this so user-friendly.

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

# Installing base packages for compatibility.

pacman -S --noconfirm base base-devel

# Funny line and start of the actual process of downloading dwm and stuff. (These are the lines you'd probably want to edit for compatibility and customization)

su $username
cd ~
mkdir work
mkdir ez-dwm-out

echo -e "
Use git to download dwm, st and dmenu? (This will make patching and adding modifications easier) [y/n] \c"
read yntwo
case $yntwo in
   [Yy]* )
   echo "Downloading through git..."
   
   # The line below is where you can customize what packages you want to download initially. I have put some minimal packages here, but you can add or remove packages as you please. 
   sudo pacman -S --noconfirm git xorg-server xorg-xinit xorg-xrandr
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
   make
   sudo make clean install
   
   cd ../st
   make
   sudo make clean install
   
   cd ../dmenu
   make
   sudo make clean install
   
   cd ~
   echo "exec dwm" >> .xinitrc
   
   ;;
   [Nn]* ) 
   echo "Downloading via wget..."
   sudo pacman -S --noconfirm wget xorg-server xorg-xinit xorg-xrandr
   
   cd work
   wget https://dl.suckless.org/dwm/dwm-6.3.tar.gz
   wget https://dl.suckless.org/st/st-0.8.5.tar.gz
   wget https://dl.suckless.org/tools/dmenu-5.1.tar.gz
   
   cd ../ez-dwm-out
   tar -xzf ../work/dwm-6.3.tar.gz
   tar -xzf ../work/st-0.8.5.tar.gz
   tar -xzf ../work/dmenu-5.1.tar.gz
   
   cd dwm-6.3
   sudo make clean install
   
   cd ../st-0.8.5
   sudo make clean install
   
   cd ../dmenu-5.1
   sudo make clean install
   
   ;;
   * )
   echo "Please answer either y (yes) or n (no)"
   ;;
esac
  
done


























# alex is hot
