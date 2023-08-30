# config-files

1. Generate SSH key, if you want to make changes later
   ```bash
   ssh-keygen
   ```
   
1. Grab the contents of the SSH key
   ```bash
   cat ~/.ssh/id_rsa.pub
   ```
  
1. Put the key out on the Github profile

1. Go to Documents

   ```bash
   cd ~/Documents
   ```

1. Download the Git Repo
   ```bash
   git clone https://github.com/ldscott1970/config-files.git
   ```

1. Change to the Git repo directory
   ```bash
   cd config-files
   ```

1. Run the setup script
   ```bash
   sh 1_setup_mac.sh
   ```
   
1.  Get zsh to know where home brew is located
    ```bash
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$LOGNAME/.zprofile
    ```

    ```bash
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```

1. Run the homebrew app install script
   ```bash
   sh 2_install_homebrew_apps.sh
   ```

1. Setup Vim
   ```bash
   sh 3_setup_vim.sh
   ```
