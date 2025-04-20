# Dotfiles Files for Unix
Includes tmux, vim, bash, and dircolors

## ./install.sh
Creates a symlink to the files in these directories.

Removes existing dotfiles!

## PS1
Red username for root, shows host only if ssh'd
![image](https://github.com/user-attachments/assets/1c3df369-b1f0-4544-b4b7-f85794d015fd)

## Install Hijack
If tmux is installed and you're not already in one, installs, wgets, and curls will spawn a tmux session for the install and terminate it after so you can keep your active terminal available to you and the download won't be lost if you lose the session.

## tmux-run
Usage tmux-run $@

Runs selected command in a tmux shell in the background and auto kills it

Why? terminal sharing, persistence through ssh disconnect, reattaching

## Vim custom commands
### Commenting
GC and GU comment and uncomment lines from normal and visual modes. Auto-detects file type for comments.
Add new file types in vim/commenting

### Copy to clipboard
In normal and visual modes, \y and \d work like yy and dd but also copy to clipboard. Supposed to auto-detect shell for appropriate clipboard but only tested for mac.

### Surrounding a Word
In normal and visual mode, \wI lets you insert characters on both sides of word or highlighted portion. It is smart, inserting "(" auto inserts ")" to the right, same with [] and {}. 
Quotes and others are doubled, so inserting ' " ' will surround the word with double quotes on both sides.

## Aliases
ls commands default to eza if it is installed.

mcdir makes and changes into a directory, allows for pathing

follow moves a file and changes to the directory it was moved into

cd auto runs ls

cda auto runs ls with -A

oops reruns previous command using $1 as new $0. Ex: "cat dir" gives "dir is a directory" error, then running "oops ls" runs "ls dir".

up will run cd .. as many times as the integer that is found at $1. Ex: "up 3" runs "cd ../../.."

back will go back to the directory that was found before most recent cd. Ex: in /scratch/data/exp1/ $ cd /users/$USER/home/results $ # some operations $ back $ # now you are in /scratch/data/exp1

tat runs tmux attach -t $1  
