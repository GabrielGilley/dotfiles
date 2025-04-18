#!/bin/bash

mv bashrc legacy_bashrc
cp ~/.bashrc bashrc

mv vimrc legacy_vimrc
cp ~/.vimrc vimrc

mv vim legacy_vim
cp -r ~/.vim .

mv tmux.conf legacy_tmux.conf
cp ~/.tmux.conf tmux.conf

mv bash_profile legacy_bash_profile
cp ~/.bash_profile bash_profile

