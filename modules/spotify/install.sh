step "Installing Spotify..."

if [ ! -f /etc/apt/sources.list.d/spotify.list ]
then
    # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
    try sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

    # 2. Add the Spotify repository
    try sudo sh -c 'echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list'

    # 3. Update list of available packages
    try sudo apt-get update

    # 4. Install Spotify
    try sudo apt-get install spotify-client
fi

next
