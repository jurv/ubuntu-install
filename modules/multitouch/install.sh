step "Installing multitouch tools..."

# Add the user to the "input" group
try sudo gpasswd -a $USER input

# Install required librairies
try sudo apt-get install -y xdotool wmctrl libinput-tools

if ! [ -x "$(command -v libinput-gestures-setup)" ]
then
    try git clone https://github.com/bulletmark/libinput-gestures.git
    try cd libinput-gestures
    try sudo make install
    try cd -

    try sudo rm -rf libinput-gestures

    # Using 'su' to take into account the new user's group ('input') without loging out
    # This will ask for the user's password, so we don't use 'try'
    su $USER -c 'libinput-gestures-setup autostart;'

    # If autostart does not launch the app, add this line:
    # su $USER -c 'libinput-gestures-setup start;'

    # Wait for 'libinput-gestures-setup' to finish its output
    sleep 3
fi

next
