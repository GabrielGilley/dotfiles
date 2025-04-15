# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export PS1="\n\[\e[1;32m\]┌──(\[\e[32m\]\u\[\e[0m\])-[\[\e[34m\]\w\[\e[0m\]]    \n\[\e[1;32m\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo     '\$'; fi) "
