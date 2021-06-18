if uname -a | grep arm64 > /dev/null; then
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

PS1='\[\e[0;31m\][\[\e[0;0m\]\u@\h: \w\[\e[0;31m\]]\[\e[0;32m\]$ \[\e[0;0m\]'
PATH=$PATH:$HOME/Documents/config-files
export CLICOLOR=1
complete -cf sudo
complete -cf man
function csrinfo() {
  if [ $# -eq 0 ]
    then
      echo "Please specify the filename or path containing the CSR."
  else
      openssl req -noout -text -in $1
      echo
  fi
}
eval "$(/opt/homebrew/bin/brew shellenv)"
