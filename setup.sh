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

[ -d ~/.config/zk.bak ] && rm -rf ~/.config/zk.bak
[ -d ~/.config/zk ] && mv -f ~/.config/zk ~/.config/zk.bak
mkdir -p ~/.config/zk
ln -s "$(pwd)/zk/zkconf.toml" ~/.config/zk/config.toml
ln -s "$(pwd)/zk/templates" ~/.config/zk
