step "Installing atom.io... "

if [ ! -f /usr/bin/atom ]
then
	try wget -O atomio.deb https://atom.io/download/deb

	# Not using "try" for dpkg as it will fail: the dependancies are missing and
	# the installation will be completed by the following apt-get install
	sudo dpkg -i atomio.deb >$LOG_STEPS 2>&1
	try sudo apt-get install -f -y

	# Install useful packages
	try python -m pip install 'python-language-server[all]'
	try apm install atom-ide-ui
	try apm install ide-python
	try apm install atom-django
	try apm install django-templates

	# After install, the path to the python executable must be changed
	# in conf from 'python' to 'python3'

fi
next
