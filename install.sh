#!/bin/bash

rm ~/.bashrc
ln -s ~/projects/configs/bashrc ~/.bashrc

rm ~/.vimrc
ln -s ~/projects/configs/vimrc ~/.vimrc

rm ~/.bash_profile
ln -s ~/projects/configs/bash_profile ~/.bash_profile

rm ~/.dircolors
ln -s ~/projects/configs/dircolors ~/.dircolors

rm ~/.tmux.conf
ln -s ~/projects/configs/tmux.conf ~/.tmux.conf

rm -r ~/.vim
ln -s ~/projects/configs/vim ~/.vim

source ~/.bash_profile
