#!/bin/bash
brew install nmap
brew install --cask macvim
brew install ipcalc
brew install iterm2
brew install bash-completion
# Install Bash and set it as the default shell
brew install bash
sudo bash -c "echo '/usr/local/bin/bash' >> /etc/shells"
chsh -s /usr/local/bin/bash
