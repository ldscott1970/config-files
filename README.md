# config-files

1. Generate SSH key, if you want to make changes later

```bash
ssh-keygen
cat ~/.ssh/config
```

  Put the key out on the Github profile

2. Go to Documents

```bash
cd ~/Documents
```

3. Download the Git Repo

```bash
git clone https://github.com/ldscott1970/config-files.git
```

4. Change to the Git repo directory

```bash
cd config-files
```

5. Run the setup script

```bash
sh 1_setup_mac.sh
```
  Get zsh to know where home brew is located

```bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$LOGNAME/.zprofile
```

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

6. Run the homebrew app install script

```bash
sh 2_install_homebrew_apps.sh
```

7. Setup Vim

```bash
sh 3_setup_vim.sh
```
