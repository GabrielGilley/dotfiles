# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

# export PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]]  (\[\e[0m\]\[\e[1;33m\]\A\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

# export PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]]\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "


# Suppress the Apple zsh message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Shut this up
set bell-style none

# -------------------------------------- Aliases -------------------------------------- # 
# Set grep colors
if command -v gdircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Use EZA if available
if command -v eza >/dev/null 2>&1; then
    alias ld='eza -d --group-directories-first .*'
    alias ll='eza -Algh --git --group-directories-first --time-style=long-iso'
    alias ls='eza --group-directories-first'
    alias la='eza -A --group-directories-first'
else
    alias ld='ls -dA --color=auto .*'            # list hidden entries one per line (closest match)
    alias ll='ls -Alh --color=auto' # long list, show hidden, human-readable sizes
    alias ls='ls --color=auto'   # one file per line, color
    alias la='ls -A --color=auto'
fi

alias pip=pip3
alias python=python3
alias pudb=pudb3
alias mypy='mypy --strict --disallow-any-explicit'



# -------------------------------------- Functions -------------------------------------- # 
follow() { mv "$1" "$2" && if [ -d "$2" ]; then cd "$2"; else cd "$(dirname "$2")"; fi }
mcdir() { mkdir -p "$1" && cd "$1"; }
tat() { tmux a -t $1; }

# ls upon cd
cd() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && ls; }
cda() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && la; }

# Easily chain cd .. by passing in int argument
up() { [ "$1" -ge 1 ] 2>/dev/null && cd $(eval printf '../'%.0s {1..$1}) || echo "Usage: up <positive integer>"; }

# Return to previous directory
back() { if [ -n "$LAST_DIR" ]; then cd "$LAST_DIR"; else echo "No previous directory recorded."; fi; }

# Change $0 of last command
oops() { last_command=$(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//'); if [[ -n "$last_command" ]]; then first_arg=$(echo "$last_command" | awk '{print $1}'); modified_command="${last_command/$first_arg/$1}"; eval "$modified_command"; else echo "No previous command found."; fi; }

# -------------------------------------- Env and Hooks -------------------------------------- # 
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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin"; export PATH;
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

follow() { mv "$1" "$2" && cd "$2"; }
mcdir() { mkdir -p "$1" && cd "$1"; }
wp() { mv "$1" "$2" && mv "$2" "$3"; }
wpf() { mv "$1" "$2" && follow "$2" "$3"; }
tat() { tmux a -t $1; }
cd() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && ls; }

cda() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && la; }

up() { [ "$1" -ge 1 ] 2>/dev/null && cd $(eval printf '../'%.0s {1..$1}) || echo "Usage: up <positive integer>"; }

# Go back to last directory
back() { if [ -n "$LAST_DIR" ]; then cd "$LAST_DIR"; else echo "No previous directory recorded."; fi; }

# Change $0 of last command
oops() { last_command=$(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//'); if [[ -n "$last_command" ]]; then first_arg=$(echo "$last_command" | awk '{print $1}'); modified_command="${last_command/$first_arg/$1}"; eval "$modified_command"; else echo "No previous command found."; fi; }

# -------------------------------------- Env and Hooks -------------------------------------- # 
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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin"; export PATH;
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

