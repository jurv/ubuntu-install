step "Installing Python3..."
try sudo apt-get install -y python3 python3-pip python3-dev build-essential

# While we're at it, install Django
try pip3 install Django==2.0

next
