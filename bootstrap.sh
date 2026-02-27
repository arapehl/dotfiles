#!/bin/bash

# Ensure zsh is installed
sudo apt-get update -y && sudo apt-get install -y zsh curl

# Clone dotfiles repo permanently if not already present
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/arapehl/dotfiles.git "$HOME/dotfiles"
fi

cd "$HOME/dotfiles"

# Install software
source ./install.zsh

# ZSH
ln -sfn "$HOME/dotfiles/zsh" "$HOME/.zsh"
ln -sf "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"

# Git
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"

# Set zsh as default shell
sudo chsh -s $(which zsh) $(whoami)
