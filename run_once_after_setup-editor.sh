#!/bin/bash


# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm -f nvim-linux64.tar.gz

NVIM_BIN="/opt/nvim-linux64/bin"
export PATH=$NVIM_BIN:$PATH

echo "export PATH=\$PATH:$NVIM_BIN" >> "$HOME/.bashrc"

# Install LunarVim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) -y

export PATH=$HOME/.local/bin:$PATH
echo "export PATH=\$HOME/.local/bin:\$PATH" >> "$HOME/.bashrc"
