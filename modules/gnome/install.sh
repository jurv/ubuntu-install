#################
# CUSTOMIZATION #
#################
WALLPAPER_URL="https://nyxrisingcom.files.wordpress.com/2016/12/mpcc4-wallpapers-451016512-1920x1080.jpg"
TERMINAL_COLOR_PALETTE="['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"
DOCK_ICON_SIZE=28
DOCK_ITEMS="['google-chrome.desktop', 'spotify.desktop', 'gmail.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'gimp.desktop', 'org.gnome.Terminal.desktop', 'gedit.desktop', 'atom.desktop']"

###############
# GNOME THEME #
###############
step "Set up custom theme... "

# Downloading Wallpaper
if [ ! -f $HOMEDIR/Images/wallpaper.jpg ]
then
  try wget -O wallpaper.jpg $WALLPAPER_URL
  try cp wallpaper.jpg $HOMEDIR/Images/
fi

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
try dconf write /org/gnome/terminal/legacy/profiles:/$profile/palette "$TERMINAL_COLOR_PALETTE"

# Dock icon size
try gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size $DOCK_ICON_SIZE

# Add link to Gmail
if [ ! -f $HOMEDIR/.local/share/applications/gmail.desktop ]
then
  try cp $INSTALL_DIR/modules/gnome/gmail.desktop $HOMEDIR/.local/share/applications/
fi

if [ ! -f /usr/share/pixmaps/gmail.png ]
then
  try sudo cp $INSTALL_DIR/modules/gnome/gmail.png /usr/share/pixmaps/
fi

# Add link to Spotify
if [ ! -f $HOMEDIR/.local/share/applications/spotify.desktop ]
then
  try cp $INSTALL_DIR/modules/gnome/spotify.desktop $HOMEDIR/.local/share/applications/
fi

if [ ! -f /usr/share/pixmaps/spotify.png ]
then
  try sudo cp $INSTALL_DIR/modules/gnome/spotify.png /usr/share/pixmaps/
fi

# Set favourites in dock
try gsettings set org.gnome.shell favorite-apps "$DOCK_ITEMS"

next
