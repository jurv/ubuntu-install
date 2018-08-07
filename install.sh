#!/bin/bash

if [ ! -f install_functions.sh ]
then
	echo "This script requires install_functions.sh to work"
	exit 1
fi

LOG_STEPS="install_log"
WALLPAPER_URL="https://nyxrisingcom.files.wordpress.com/2016/12/mpcc4-wallpapers-451016512-1920x1080.jpg"

. install_functions.sh

cd /tmp


##################
# INSTALL CHROME #
##################
step "Installing Google Chrome... "
CHROME_DIR="/opt/google/chrome"

if [ ! -d $CHROME_DIR ]
then
	try sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	try sudo sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -'
	try sudo apt-get update
	try sudo apt-get install google-chrome-stable
fi
next


###################
# INSTALL ATOM.IO #
###################
step "Installing atom.io... "

if [ ! -f /usr/bin/atom ]
then
	try wget -O atomio.deb https://atom.io/download/deb

	# Not using "try" for dpkg as it will fail: the dependancies are missing and
	# the installation will be completed by the following apt-get install
	sudo dpkg -i atomio.deb >$LOG_STEPS 2>&1
	try sudo apt-get install -f -y
fi
next


###############
# GNOME THEME #
###############
step "Set up custom theme... "
HOMEDIR=$( getent passwd "$USER" | cut -d: -f6 )

# Downloading Wallpaper
try wget -O wallpaper.jpg $WALLPAPER_URL
try cp wallpaper.jpg $HOMEDIR/Images/


# Background
try gsettings set org.gnome.desktop.background  picture-uri file://$HOMEDIR/Images/wallpaper.jpg

# Lock screen background
try gsettings set org.gnome.desktop.screensaver picture-uri file://$HOMEDIR/Images/wallpaper.jpg

# Login screen background
if [ ! -f /etc/alternatives/gdm3.css.backup ]
then
	try sudo cp wallpaper.jpg /usr/share/backgrounds/
	try sudo cp /etc/alternatives/gdm3.css /etc/alternatives/gdm3.css.backup
	try sudo sh -c 'echo "#lockDialogGroup {background: #000000 url(file:///usr/share/backgrounds/wallpaper.jpg);background-repeat: no-repeat;background-size: cover;background-position: center; }" >> /etc/alternatives/gdm3.css'
fi

# Terminal colors (stop using system colors and use Dark Tango theme)
profile="$(dconf list /org/gnome/terminal/legacy/profiles:/ | sed 's./..')"
try dconf write /org/gnome/terminal/legacy/profiles:/$profile/use-theme-colors "false"
try dconf write /org/gnome/terminal/legacy/profiles:/$profile/palette "['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"
next

# Dock icon size
try gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 28

# Set favourites in dock
try gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.Terminal.desktop', 'gedit.desktop', 'atom.desktop']"

next

###########
# EXITING #
###########
echo -e "Done !\n"
read -p "Reboot now? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot -n
fi

exit 0
