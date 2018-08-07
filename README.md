# UBUNTU INSTALL

This repository contains shell scripts used to set up a newly installed Ubuntu with a Gnome desktop environment (default environment in Ubuntu 18.4).

It contains two scripts:
*  `install_functions.sh`: a set of functions used to handle the execution of consecutives shell commands and check their return status. The status is then displayed in the terminal (OK, FAIL, ...).
It was adapted for Ubuntu from [the RedHat/CentOS code from John Kugelman on StackOverflow](https://stackoverflow.com/a/5196220).
* `install.sh`: the actual installation script

Currently the installation script:
* Install Google Chrome
* Install Atom.io
* Install Git
* Install Gimp
* Customize Gnome by:
  * setting a desktop, lock screen and login page wallpaper (the same image)
  * setting a dock icon size
  * setting dock items ("favourites")
  * setting terminal colors

All the values used for customization can be changed through variables defined in the script.

![Install Screenshot](docs/screenshot.png)
