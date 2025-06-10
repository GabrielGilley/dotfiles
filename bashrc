# .bashrc

# -------------------------------------- Set Work Proxies -------------------------------------- # 

if [ -f ~/.bashrc.d/proxies ]; then
    source ~/.bashrc.d/proxies
fi

# -------------------------------------- Env and Hooks -------------------------------------- # 

# Homebrew
if [[ "$(uname)" == 'Darwin' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin"; export PATH;
    [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# -------------------------------------- Environment -------------------------------------- # 
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ---- Prompt ---- #

error_flag=0

set_prompt() {

    # If the flag is set, replace $ and # with a red X.
    # If user is root, change name to red and use #
    # If ssh'd, add hostname
    if [ $? -eq 0 ]; then
         PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

    # No error in the last
    else
         PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo \[\e[31m\]'X'\[\e[0m\]; else echo \[\e[31m\]'X'\[\e[0m\]; fi) "
    fi
}

# Set PROMPT_COMMAND to call set_prompt before displaying the prompt
PROMPT_COMMAND='set_prompt; history -a'

# --------------- #
# export PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

export EZA_COLORS="ur=1;33:uw=1;31:ux=1;32:gr=1;33:gw=1;31:gx=1;32:tr=1;33:tw=1;31:tx=1;32:uu=1;32:gu=1;32:da=1;33:di=1;36:ga=1;33:gm=1;33:gd=1;31:gn=1;32:sb=1;33:ln=1;31:or=31"
export BASH_SILENCE_DEPRECATION_WARNING=1
set bell-style none

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$HOME/edirect:$PATH
export PATH=$PATH:$HOME/.local/bin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
# source "$HOME/.cargo/env"

# -------------------------------------- Aliases -------------------------------------- #
# Set grep colors and ls colors if gdircolors is available
if command -v gdircolors >/dev/null 2>&1; then
    if [ -r ~/.dircolors ]; then
        eval "$(gdircolors -b ~/.dircolors)"
    else
        eval "$(gdircolors -b)"
    fi
fi

# Always set grep color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Set diff color
alias diff='diff -y --color'

# Use EZA if available
if command -v eza >/dev/null 2>&1; then
    alias ld='eza -d --group-directories-first .*'
    alias ll='eza -Algh --git --group-directories-first --time-style=long-iso'
    alias ls='eza --group-directories-first'
    alias la='eza -A --group-directories-first'
else
    alias ld='ls -dA --color=auto .*' # list hidden entries
    alias ll='ls -Alh --color=auto'   # long list, human-readable
    alias ls='ls --color=auto'        # simple listing
    alias la='ls -A --color=auto'     # show almost all
fi

alias python=python3
alias pudb=pudb3
alias mypy='mypy --strict --disallow-any-explicit'
alias tmls='tmux ls'
alias py='source ~/.default_python/bin/activate'
alias batcat='bat'

# Hijacks most installs and sends them to a tmux session
# source ~/.bashrc.d/installs_to_background

# Throw a command into a tmux session
source ~/.bashrc.d/tmux_run

# Hijacks pip and runs it with proxy settings
if [ -f ~/.bashrc.d/pip_proxy ]; then
    source ~/.bashrc.d/pip_proxy
fi

# -------------------------------------- Functions -------------------------------------- # 
follow() { mv "$1" "$2" && if [ -d "$2" ]; then cd "$2"; else cd "$(dirname "$2")"; fi }
mcdir() { mkdir -p "$1" && cd "$1"; }
tat() { tmux a -t $1; }
tks() { tmux kill-session -t $1; }
tns() { tmux new-session -s $1; }
tans() { tmux new-session -s $1 && tmux a -t $1; } 

# ls upon cd
cd() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && ls; }
cda() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && la; }

# Easily chain cd .. by passing in int argument
up() { [ "$1" -ge 1 ] 2>/dev/null && cd $(eval printf '../'%.0s {1..$1}) || echo "Usage: up <positive integer>"; }

# Return to previous directory
back() { if [ -n "$LAST_DIR" ]; then cd "$LAST_DIR"; else echo "No previous directory recorded."; fi; }

# Change $0 of last command
oops() { last_command=$(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//'); if [[ -n "$last_command" ]]; then first_arg=$(echo "$last_command" | awk '{print $1}'); modified_command="${last_command/$first_arg/$1}"; eval "$modified_command"; else echo "No previous command found."; fi; }

# View a markdown file prettily
viewmd() { pandoc "$1" -t html | w3m -T text/html 2>/dev/null; }

# Add, commit, and push
gita() { [ "$#" -ne 2 ] && { echo "Usage: gita file/to/add \"commit message\""; return 1; } || git add "$1" && git commit -m "$2" && git push; }

