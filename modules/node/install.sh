step "Installing NodeJS..."

try sudo apt-get install -y nodejs npm

# We used the outdated version installed by apt to install a more recent one
try sudo npm install --global npm

# Once the recent one is installed, we remove the oldest
try sudo apt-get remove npm

next
