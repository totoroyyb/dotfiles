#!/bin/bash


# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

PATH="$PATH:/opt/nvim-linux64/bin"

echo "export PATH=$PATH" >> "$HOME/.bashrc"
source "$HOME/.bashrc"

# Install LunarVim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

echo "export PATH=$HOME/.local/bin:$PATH" >> "$HOME/.bashrc"
source "$HOME/.bashrc"
