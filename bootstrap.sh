#!/bin/bash

# Ensure zsh is installed
sudo apt-get update -y && sudo apt-get install -y zsh curl

# Install software
source ./install.zsh

# ZSH
ln -sfn ~/dotfiles/zsh ~/.zsh
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# Git
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
