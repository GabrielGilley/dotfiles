# Dotfiles Files for Unix
Includes tmux, vim, bash, and dircolors

## ./link\_dotfiles.sh
Creates a symlink to the files in these directories.

Removes existing dotfiles!

## PS1
Red username for root, shows host only if ssh'd
![image](https://github.com/user-attachments/assets/1c3df369-b1f0-4544-b4b7-f85794d015fd)

## Install Hijack
If tmux is installed and you're not already in one, installs, wgets, and curls will spawn a tmux session for the install and terminate it after so you can keep your active terminal available to you and the download won't be lost if you lose the session.

## Functions and Aliases
### tmux-run
Usage tmux-run $@

Runs selected command in a tmux shell in the background and auto kills it

Why? terminal sharing, persistence through ssh disconnect, reattaching

### Directory Navigation 
```ls``` commands default to ```eza``` if it is installed.

mcdir makes and changes into a directory, allows for pathing

follow moves a file and changes to the directory it was moved into

cd auto runs ls

cda auto runs ls with -A

up will run cd .. as many times as the integer that is found at $1. Ex: "up 3" runs "cd ../../.."

back will go back to the directory that was found before most recent cd. Ex: in /scratch/data/exp1/ $ cd /users/$USER/home/results $ # some operations $ back $ # now you are in /scratch/data/exp1

mvn, lsn, cpn, lan, ldn, lln all will grab the parent directory of the first argument and use it for the second.

Example: mv /cscratch/dir/temp/really/long/name/file.txt /cscratch/dir/temp/really/long/name/file1.txt becomes mvn /cscratch/dir/temp/really/long/name/file.txt file1.txt

### Other
#### Oops:

oops $1 reruns previous command using $1 as new $0. Ex: "cat dir" gives "dir is a directory" error, then running "oops ls" runs "ls dir".

oops add $2 [$3 ...] reruns previous command with any number of arguments prepended.

oops remove $2 [$3 ...] reruns previous command with any number of arguments removed.

The three clauses can be separated in any order with "and" to combine them.

For example:

$ cat /tmp /scratch

oops add time watch sudo and remove /scratch and cd

will run `time watch sudo cd /tmp`

Oops will ignore previous "oops" commands, so one can then follow up with:

oops add time watch sudo and remove /scratch and ls

which will run `time watch sudo ls /tmp`

#### Tmux:
tat $1 runs tmux attach -t $1  

tns $1 will make a new session called $1

tmls will list tmux sessions

tks $1 will kill a tmux session

tans $1 will make and attach to a new session

## Vim custom commands
### Commenting
gc and gu comment and uncomment lines from normal and visual modes. Auto-detects file type for comments.
Add new file types in vim/commenting

### Copy to clipboard
In normal and visual modes, \y and \d work like yy and dd but also copy to clipboard. Supposed to auto-detect shell for appropriate clipboard but only tested for mac.

### Surrounding a Word
Tpope's:
https://github.com/tpope/vim-surround.git
