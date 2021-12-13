#!/bin/zsh

# Install software
source ./install.zsh

# ZSH
ln -sfn ~/dotfiles/zsh ~/.zsh
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# Git
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
