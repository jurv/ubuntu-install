#!/bin/bash

if [ ! -f install_functions.sh ]
then
	echo "This script requires install_functions.sh to work"
	exit 1
fi

LOG_STEPS="install_log"
INSTALL_DIR=$(pwd)

##############
# SETTING UP #
##############
. install_functions.sh

cd /tmp

# Ask for sudo password, we're gonna need it
sudo -k echo

######################
# INSTALLING MODULES #
######################
for module in $INSTALL_DIR/modules/*; do

	# If a directory was found
	if [ -d ${module} ]; then
		if [ -f $module/install.sh ]; then
			. $module/install.sh
		fi
  fi

done

###########
# EXITING #
###########
echo -e "Done !\n"
read -p "Reboot now? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot -n
fi

echo

exit 0
