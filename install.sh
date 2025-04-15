#!/bin/bash

mv ~/.vimrc ~/.legacy_vimrc
mv ~/.bashrc ~/.legacy_bashrc
mv ~/.tmux.conf ~/.legacy_tmux.conf
mv ~/.bash_profile ~/.legacy_bash_profile

mv vimrc ~/.vimrc
mv bashrc ~/.bashrc
mv tmux.conf ~/.tmux.conf
mv bash_profile ~/.bash_profile

source ~/.bashrc
source ~/.bash_profile
