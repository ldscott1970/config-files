#!/bin/bash
rm -f ~/.bash_profile
ln -s ~/Documents/config-files/bash_profile ~/.bash_profile
ln -s ~/Documents/config-files/vimrc.conf ~/.vimrc

# Load bash profile
source ~/.bash_profile

# Install xcode commandline tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
