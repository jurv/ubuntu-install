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
