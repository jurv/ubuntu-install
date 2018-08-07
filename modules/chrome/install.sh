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
