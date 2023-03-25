#!/bin/bash
rm -f ~/.bash_profile
ln -s ~/Documents/config-files/bash_profile ~/.bash_profile
ln -s ~/Documents/config-files/vimrc.conf ~/.vimrc
ln -s ~/Documents/config-files/ssh-config ~/.ssh/config && chmod 600 ~/.ssh/config

# Setup Git
git config pull.rebase false

# Load bash profile
source ~/.bash_profile

# Install xcode commandline tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make executable
chmod +x *.sh

# Download new palo vpn cert
mkdir ~/.cert
echo | openssl s_client -connect sssnssvpn.bor.usg.edu:443 -showcerts -legacy_renegotiation > ~/.cert/sssnssvpn.bor.usg.edu.crt
