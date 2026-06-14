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

[ -d ~/.config/ghostty.bak ] && rm -rf ~/.config/ghostty.bak
[ -d ~/.config/ghostty ] && mv -f ~/.config/ghostty ~/.config/ghostty.bak
mkdir -p ~/.config/ghostty
ln -s "$(pwd)/config.ghostty" ~/.config/ghostty/config.ghostty

[ -d ~/.local/bin ] || mkdir -p ~/.local/bin
ln -sf $(pwd)/bin/* ~/.local/bin/

[ -d ~/.emacs.d.bak ] && rm -rf ~/.emacs.d.bak
[ -d ~/.emacs.d ] && mv -f ~/.emacs.d ~/.emacs.d.bak
mkdir -p ~/.emacs.d
ln -s "$(pwd)/init.el" ~/.emacs.d/init.el
