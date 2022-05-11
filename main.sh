#!/bin/bash

# If you somehow don't have bash, please install it. It's a little something guys like me in the tech world call a "dependency"
# Also, if you get a "command not found" error, then please install that using "sudo pacman -S (command, or package that contains it)"
# No, I don't know why I'm making this so user-friendly.


# make a user and check if the groups have a space in them or not

echo -e "

Please enter the name of the user to create: \c"
read username

echo -e "
Please enter the groups you would like the user to be in (No spaces, separated by commas): \c"
read groups

case "$groups" in
  *\ *)
    echo "Oops! A space was detected. Try again without spaces."
    ;;
  *,*)
    useradd -m -G $groups $username
    ;;
  *)
    echo "no comma"
    ;;
esac



































# alex is hot
