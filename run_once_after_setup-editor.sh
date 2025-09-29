#!/bin/bash

# Function to compare versions
version_greater_equal() {
  [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

install_nvim() {
  # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

  sudo rm -rf /opt/nvim
  # sudo tar -C /opt -xzf nvim-linux64.tar.gz
  # rm -f nvim-linux64.tar.gz
  # NVIM_BIN="/opt/nvim-linux64/bin"

  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  rm -f nvim-linux-x86_64.tar.gz
  NVIM_BIN="/opt/nvim-linux-x86_64/bin"

  export PATH=$NVIM_BIN:$PATH
}

# Required version
nvim_required_version="0.10.0"

if ! command -v nvim &>/dev/null; then
  echo "Neovim is not installed."
  # Install NeoVim
  install_nvim
else
  echo "Neovim is already installed."
  # Get the installed version of Neovim
  nvim_installed_version=$(nvim --version | head -n 1 | awk '{print $2}')
  if version_greater_equal "$nvim_installed_version" "$nvim_required_version"; then
    echo "Neovim version $installed_version is installed and is greater than or equal to $required_version. Version check passed."
  else
    echo "Neovim version $installed_version is installed but is less than $required_version. Installing Neovim..."
    install_nvim
  fi
fi

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Install ripgrep
# NOTE: ripgrep installation is now moved to install-package script
# curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
# sudo dpkg -i ripgrep_13.0.0_amd64.deb
# rm ripgrep_13.0.0_amd64.deb

# Install fd
# sudo apt-get install fd-find -y
# mkdir -p ~/.local/bin
# ln -s $(which fdfind) ~/.local/bin/fd

# Install LazyVim
# mv ~/.config/nvim{,.bak}

# optional but recommended
# mv ~/.local/share/nvim{,.bak}
# mv ~/.local/state/nvim{,.bak}
# mv ~/.cache/nvim{,.bak}

# git clone https://github.com/LazyVim/starter ~/.config/nvim
# rm -rf ~/.config/nvim/.git

export PATH=$HOME/.local/bin:$PATH
# echo "export PATH=\$HOME/.local/bin:\$PATH" >> "$HOME/.bashrc"
