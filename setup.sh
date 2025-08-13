#!/bin/bash

[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
ln -s "$(pwd)/zshrc" ~/.zshrc

[ -f ~/.zshenv ] && mv ~/.zshenv ~/.zshenv.bak
ln -s "$(pwd)/zshenv" ~/.zshenv

[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s "$(pwd)/tmux.conf" ~/.tmux.conf

[ -d ~/.config/nvim.bak ] && rm -rf ~/.config/nvim.bak
[ -d ~/.config/nvim ] && mv -f ~/.config/nvim ~/.config/nvim.bak
mkdir -p ~/.config/nvim
ln -s "$(pwd)/vim/init.lua" ~/.config/nvim/init.lua
ln -s "$(pwd)/vim/lua" ~/.config/nvim
