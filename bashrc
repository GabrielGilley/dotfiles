# .bashrc
# Fancy two-line prompt (Kali-style, no hostname, with colors)


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


export PS1="\n\[\e[1;32m\]┌──(\[\e[32m\]\u\[\e[0m\])-[\[\e[34m\]\w\[\e[0m\]]\n\[\e[1;32m\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

eval "$(/opt/homebrew/bin/brew shellenv)"
 
 
# Suppress the Apple zsh message
export BASH_SILENCE_DEPRECATION_WARNING=1

set bell-style none
# stty -ixon
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
 
# User specific aliases and functions
function cd { builtin cd "$1" && ls; }
function cda { builtin cd "$1" && ls -A; }
function follow { mv "$1" "$2" && cd "$2"; }
function wp { mv "$1" "$2" && mv "$2" "$3"; }
function wpf { mv "$1" "$2" && follow "$2" "$3"; }
function tat { tmux a -t $1; }
 
oops() {
    # Get the last command from the history
    last_command=$(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//')
 
    # Replace the first argument with the argument passed to the function
    if [[ -n "$last_command" ]]; then
        # Extract the first argument from the last command
        first_arg=$(echo "$last_command" | awk '{print $1}')
 
        # Replace the first argument with the argument passed to the function
        modified_command="${last_command/$first_arg/$1}"
 
        # Execute the modified command
        eval "$modified_command"
    else
        echo "No previous command found."
    fi
}
 
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
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin"; export PATH;
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

if command -v gdircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

