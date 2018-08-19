step "Installing Git..."

try sudo apt-get install -y git

# Git prompt
if [ ! -d $HOMEDIR/.bash-git-prompt ]
then

    try cd $HOMEDIR

    try git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

    try sudo sh -c "cp $HOMEDIR/.bashrc $HOMEDIR/.bashrc.bck"
    try sudo sh -c "cat $INSTALL_DIR/modules/git/bashrc-config >> $HOMEDIR/.bashrc"

    try cd -
fi

next
