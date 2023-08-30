#!/bin/bash
brew install nmap
brew install --cask macvim
brew install ipcalc
brew install iterm2
brew install openconnect
brew install bash-completion
# Install Bash and set it as the default shell
brew install bash
if uname -a | grep arm64 > /dev/null; then
  sudo bash -c "echo '/opt/homebrew/bin/bash' >> /etc/shells"
  chsh -s /opt/homebrew/bin/bash
else
  sudo bash -c "echo '/usr/local/bin/bash' >> /etc/shells"
  chsh -s /usr/local/bin/bash
fi

