[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
PS1='\[\e[0;31m\][\[\e[0;0m\]\u@\h: \w\[\e[0;31m\]]\[\e[0;32m\]$ \[\e[0;0m\]'
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
