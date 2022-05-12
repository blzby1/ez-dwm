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
  echo "Invalid username."
  exit
  ;;
  * )
  echo "valid"
  ;;
esac

echo -e "
Please enter the groups you would like the user to be in (No spaces, separated by commas): \c"
read groups

case "$groups" in
  *\ * )
    echo "Oops! A space was detected. Try again without spaces."
    exit
    ;;
  *,* )
    ;;
  * )
    echo "Weird format detected. Either you only wanted one group, messed up badly, or forgot commas."
    echo -e "
Continue anyway? [y/n] \c"
    read yn
    case $yn in
        [Yy]* )
        ;;
        [Nn]* ) 
        exit
        ;;
        * )
        echo "Please answer either y (yes) or n (no)"
        ;;
    esac
    ;;
esac


useradd -m -G $groups $username

# I should make the above code a utility for linux beginners. Maybe someday.

# Installing base packages for compatibility.

pacman -S --noconfirm base base-devel

# Funny line and start of the actual process of downloading dwm and stuff. (These are the lines you'd probably want to edit for compatibility and customization)

su $username
cd ~
mkdir work
rm -rf work # ******REMOVE THIS LATER!!!!!!!!!!!!******




























# alex is hot
