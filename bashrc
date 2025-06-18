# .bashrc

# -------------------------------------- set work proxies -------------------------------------- # 

if [ -f ~/.set_proxy ]; then
    source ~/.set_proxy
fi

if [ -f ~/.bashrc.d/proxies ] && [ "$SET_PROXIES" = true ]; then
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

export EDITOR=vim

# -------------------------------------- Environment -------------------------------------- # 

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# <<<<<<< HEAD
# user_color() {
#   if [[ $EUID == 0 ]]; then
#     echo -ne '\[\e[1;91m\]'
#   else
#     echo -ne '\[\e[1;32m\]'
#   fi
# }

# export PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "
# =======
# ---- Prompt ---- #

error_flag=0

set_prompt() {
    if [ $? -eq 0 ]; then
         PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo '#'; else echo '\$'; fi) "

    # No error in the last
    else
         PS1="\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]┌──(\u)$(if [[ -n "${SSH_CONNECTION-}" ]]; then echo '\e[1;33m@\h'; fi)\[\e[0m\]-[\[\e[1;96m\]\w\[\e[0m\]] (\[\e[1;33m\]\t\[\e[0m\])\n\[\$(if [[ \$EUID == 0 ]]; then echo '\e[1;91m'; else echo '\e[1;32m'; fi)\]└─\[\e[0m\] \$(if [[ \$EUID == 0 ]]; then echo \[\e[31m\]'X'\[\e[0m\]; else echo \[\e[31m\]'X'\[\e[0m\]; fi) "
    fi
}

PROMPT_COMMAND='set_prompt; history -a'

# --------------- #
# >>>>>>> 70d20b13eaf7a7e7f12f6e6c462cbbc8a339a515

export EZA_COLORS="ur=1;33:uw=1;31:ux=1;32:gr=1;33:gw=1;31:gx=1;32:tr=1;33:tw=1;31:tx=1;32:uu=1;32:gu=1;32:da=1;33:di=1;36:ga=1;33:gm=1;33:gd=1;31:gn=1;32:sb=1;33:ln=1;31:or=31"
export BASH_SILENCE_DEPRECATION_WARNING=1

# Shut this up
set bell-style none

# <<<<<<< HEAD
# # Enable vim keybinds in the command line
# set -o vi

# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).
# # =======
# Get vim on the command line
set -o vi

bind -m vi-command '"H": "b"'
bind -m vi-command '"L": "El"'
bind -m vi-command '"J": "}"'
bind -m vi-command '"K": "{"'

bind -m vi-command '"<C-h>": "^"'
bind -m vi-command '"<C-l>": "$"'
bind -m vi-command '"<C-H>": "0"'
bind -m vi-command '"<C-L>": "^"'

# Programmable completion
# >>>>>>> 70d20b13eaf7a7e7f12f6e6c462cbbc8a339a515
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
# We throw 'e' on the end as these are internal, 'ls' is overwritten with a function.
if command -v eza >/dev/null 2>&1; then
    alias lde='eza -d --group-directories-first .*'
    alias lle='eza -Algh --git --group-directories-first --time-style=long-iso'
    alias lse='eza --group-directories-first'
    alias lae='eza -A --group-directories-first'
else
    alias lde='command ls -dA --color=auto .*' # list hidden entries
    alias lle='command ls -Alh --color=auto'   # long list, human-readable
    alias lse='command ls --color=auto'        # simple listing
    alias lae='command ls -A --color=auto'     # show almost all
fi

alias python=python3
alias pudb=pudb3
alias mypy='mypy --strict --disallow-any-explicit'
alias tmls='tmux ls'
alias tr='tmux-run'
alias py='source ~/.default_python/bin/activate'
alias bat='batcat'
alias rub='git push origin --delete'
alias lub='git branch -d'
alias LUB='git branch -D'
rlub() { lub $1 && rub $1; }
RLUB() { LUB $1 && rub $1; }
alias submod='git submodule update --init --recursive'

# Hijacks most installs and sends them to a tmux session
# source ~/.bashrc.d/installs_to_background

# Throw a command into a tmux session
source ~/.bashrc.d/tmux_run

# -------------------------------------- Functions -------------------------------------- # 

follow() { mv "$1" "$2" && if [ -d "$2" ]; then cd "$2"; else cd "$(dirname "$2")"; fi }
mcdir() { mkdir -p "$1" && cd "$1"; }
tat() { tmux a -t $1; }
tks() { tmux kill-session -t $1; }
tns() { tmux new-session -s $1; }
tans() { tmux new-session -s $1 && tmux a -t $1; } 

# ls upon cd
cd()  { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && ls; }
cda() { [ -n "$PWD" ] && export LAST_DIR="$PWD"; builtin cd "$@" && la; }


# Override ls for lsn convenience
# ls() {echo "Test"; }
ls() { if [ "$#" -gt 1 ]; then echo "Usage: ls [directory]"; return 1; fi; if [ -d "${1:-.}" ]; then LAST_LS_DIR="${1:-.}"; lse "${1:-.}"; else echo "Directory '${1:-.}' does not exist."; fi; }
ld() { if [ "$#" -gt 1 ]; then echo "Usage: ld [directory]"; return 1; fi; if [ -d "${1:-.}" ]; then LAST_LS_DIR="${1:-.}"; lde "${1:-.}"; else echo "Directory '${1:-.}' does not exist."; fi; }
ll() { if [ "$#" -gt 1 ]; then echo "Usage: ll [directory]"; return 1; fi; if [ -d "${1:-.}" ]; then LAST_LS_DIR="${1:-.}"; lle "${1:-.}"; else echo "Directory '${1:-.}' does not exist."; fi; }
la() { if [ "$#" -gt 1 ]; then echo "Usage: la [directory]"; return 1; fi; if [ -d "${1:-.}" ]; then LAST_LS_DIR="${1:-.}"; lae "${1:-.}"; else echo "Directory '${1:-.}' does not exist."; fi; }

# ls()  { [ "$#" -gt 1 ] && { echo "Usage: ls [directory]"; return 1; } && [ -d "${1:-.}" ] && { LAST_LS_DIR="${1:-.}"; lse "${1:-.}"; } || echo "Directory '${1:-.}' does not exist."; }
# ld()  { [ "$#" -gt 1 ] && { echo "Usage: ld [directory]"; return 1; } && [ -d "${1:-.}" ] && { LAST_LS_DIR="${1:-.}"; lde "${1:-.}"; } || echo "Directory '${1:-.}' does not exist."; }
# ll()  { [ "$#" -gt 1 ] && { echo "Usage: ll [directory]"; return 1; } && [ -d "${1:-.}" ] && { LAST_LS_DIR="${1:-.}"; lle "${1:-.}"; } || echo "Directory '${1:-.}' does not exist."; }
# la()  { [ "$#" -gt 1 ] && { echo "Usage: la [directory]"; return 1; } && [ -d "${1:-.}" ] && { LAST_LS_DIR="${1:-.}"; lae "${1:-.}"; } || echo "Directory '${1:-.}' does not exist."; }

# Easily chain cd .. by passing in int argument
up(){ n=${1:-1}; [ "$n" -ge 1 ] 2>/dev/null && cd "$(eval printf '../'%.0s {1..$n})" || echo "Usage: up <positive integer>"; }

# Return to previous directory
back() { if [ -n "$LAST_DIR" ]; then cd "$LAST_DIR"; else echo "No previous directory recorded."; fi; }

# Change $0 of last command
oops() { last_command=$(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//'); if [[ -n "$last_command" ]]; then first_arg=$(echo "$last_command" | awk '{print $1}'); modified_command="${last_command/$first_arg/$1}"; eval "$modified_command"; else echo "No previous command found."; fi; }

# View a markdown file prettily
viewmd() { pandoc "$1" -t html | w3m -T text/html 2>/dev/null; }

# <<<<<<< HEAD
# Renames a pdf to LastName-Year-title-separated-by-hyphens.pdf
# rename_pdf  oldfile.pdf
# → Lastname-year-title-with-hyphens.pdf
rename_pdf() {
    local in="$1"
    [[ -f "$in" ]] || { echo "rename_pdf: file not found"; return 1; }

    # ---------- pull metadata ---------------------------------------------
    local info author title year lastname slug
    info=$(pdfinfo -- "$in")                                   || return $?

    author=$(echo "$info" | awk -F': ' '/^Author/   {print $2; exit}')
    title=$( echo "$info" | awk -F': ' '/^Title/    {print $2; exit}')
    year=$(  echo "$info" | awk       '/^CreationDate/ {print $(NF-1); exit}')
    [ -n "$year" ] || year=$(echo "$info" | awk '/^ModDate/ {print $(NF-1); exit}')

    # ---------- transform pieces ------------------------------------------
    # first author → last word before first comma
    lastname=$(echo "$author" | cut -d',' -f1 | awk '{print $NF}')

    # capitalise first letter, rest lowercase – portable
    lastname=$(printf '%s\n' "$lastname" | \
               awk '{printf toupper(substr($0,1,1)) tolower(substr($0,2))}')

    # title → lower-case slug, non-alnum → "-"
    slug=$(echo "$title" \
             | tr '[:upper:]' '[:lower:]' \
             | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')

    local out="${lastname}-${year}-${slug}.pdf"

    # ---------- rename safely --------------------------------------------
    if [ -e "$out" ]; then
        echo "rename_pdf: target '${out}' already exists" >&2
        return 2
    fi
    mv -i -- "$in" "$out" && echo "renamed → $out"
}

save_file() { 
    # usage check
    [ -f "$1" ] || { echo "Usage: save_file <existing-file>"; return 1; }

    # expand to an absolute POSIX path, then hand it to AppleScript
    osascript -e 'set the clipboard to (POSIX file "'"$(realpath "$1")"'")'
}
# =======
# Move or copy and assume same directory
mvn() { [ "$#" -ne 2 ] && { echo "Usage: mvn long/path/to/source/file assume_starting_in_same_dir_file"; return 1; } || mv "$1" "$(dirname "$1")/$2"; }
cpn() { [ "$#" -ne 2 ] && { echo "Usage: cpn long/path/to/source/file assume_starting_in_same_dir_file"; return 1; } || cp "$1" "$(dirname "$1")/$2"; }


# lsn will ls but assume the parent directory of your last ls.
# Useful for 
# ----------------------------------------------
# |$ ls ../../../really/long/path/to/directory |
# |--> dir1 dir2 dir3 dir4 file.md             |
# |$ lsn dir1                                  |
# ----------------------------------------------

lsn() { TARGET_DIR="${LAST_LS_DIR:-$(pwd)}/$1"; [ -d "$TARGET_DIR" ] && ls "$TARGET_DIR" || echo "Directory '$TARGET_DIR' does not exist."; }
lan() { TARGET_DIR="${LAST_LS_DIR:-$(pwd)}/$1"; [ -d "$TARGET_DIR" ] && la "$TARGET_DIR" || echo "Directory '$TARGET_DIR' does not exist."; }
ldn() { TARGET_DIR="${LAST_LS_DIR:-$(pwd)}/$1"; [ -d "$TARGET_DIR" ] && ld "$TARGET_DIR" || echo "Directory '$TARGET_DIR' does not exist."; }
lln() { TARGET_DIR="${LAST_LS_DIR:-$(pwd)}/$1"; [ -d "$TARGET_DIR" ] && ll "$TARGET_DIR" || echo "Directory '$TARGET_DIR' does not exist."; }

# Add, commit, and push
gita() { [ "$#" -lt 2 ] && { echo "Usage: gita file1 [file2 ...] \"commit message\""; return 1; } || git add "${@:1:$#-1}" && git commit -m "${@: -1}" && git push; }

# Revert from last pull
unpull() { if [[ -n $(git status --porcelain) ]]; then echo "There are uncommitted changes. Please commit or stash them before running unpull."; return 1; fi; if [[ -n $(git log --branches --not --remotes) ]]; then echo "There are unpushed commits. Please push or reset them before running unpull."; return 1; fi; last_commit_hash=$(git reflog show HEAD | awk 'NR==2 {print $1}'); git reset --hard "$last_commit_hash"; echo "Successfully reset to the commit before the last pull: $last_commit_hash"; }
# >>>>>>> 70d20b13eaf7a7e7f12f6e6c462cbbc8a339a515

