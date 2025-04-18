#!/bin/bash

mv ~/.vimrc ~/.legacy_vimrc
mv ~/.bashrc ~/.legacy_bashrc
mv ~/.tmux.conf ~/.legacy_tmux.conf
mv ~/.bash_profile ~/.legacy_bash_profile
mv ~/.vim ~/.legacy_vim
mv ~/.dircolors ~/.legacy_dircolors

mv vimrc ~/.vimrc
mv bashrc ~/.bashrc
mv tmux.conf ~/.tmux.conf
mv bash_profile ~/.bash_profile
mv vim ~/.vim
mv dircolors ~/.dircolors

source ~/.bashrc
source ~/.bash_profile
tmux source-file ~/.tmux.conf
