# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export PS1="\n\[\e[1;32m\]┌──(\[\e[32m\]\u\[\e[0m\])-[\[\e[34m\]\w\[\e[0m\]]    \n\[\e[1;32m\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo     '\$'; fi) "

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

eval "$(/opt/homebrew/bin/brew shell env)"
