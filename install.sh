#!/bin/bash

if [ ! -f install_functions.sh ]
then
	echo "This script requires install_functions.sh to work"
	exit 1
fi

LOG_STEPS="install_log"
. install_functions.sh

cd /tmp

# INSTALL CHROME
step "Installing Google Chrome... "
CHROME_APT="/etc/apt/sources.list.d/google-chrome.list"

if [ ! -f $CHROME_APT ]
then
	try sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	try sudo sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -'
	try sudo apt-get update
	try sudo apt-get install google-chrome-stable
fi
next


