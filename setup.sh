#!/bin/bash

[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
ln -s "$(pwd)/bashrc" ~/.bashrc

[ -f ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.bak
ln -s "$(pwd)/bash_profile" ~/.bash_profile

[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s "$(pwd)/tmux.conf" ~/.tmux.conf

[ -d ~/.config/nvim.bak ] && rm -rf ~/.config/nvim.bak
[ -d ~/.config/nvim ] && mv -f ~/.config/nvim ~/.config/nvim.bak
mkdir -p ~/.config/nvim
ln -s "$(pwd)/vim/init.lua" ~/.config/nvim/init.lua
ln -s "$(pwd)/vim/lua" ~/.config/nvim

