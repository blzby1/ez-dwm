#!/bin/bash

# If you somehow don't have bash, please install it. It's a little something guys like me in the tech world call a "dependency"
# Also, if you get a "command not found" error, then please install that using "sudo pacman -S (command, or package that contains it)"
# No, I don't know why I'm making this so user-friendly.


echo -e "

Please enter the name of the user to create: \c"
read username

echo "
Please enter the groups you would like the user to be in (No spaces, separated by commas): \c"
read groups

# I may or may not add some logic here to make sure the groups were formatted correctly. For now, it will just (hopefully) error out.

useradd -m -G $groups $username


































# alex is hot