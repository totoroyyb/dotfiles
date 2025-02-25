#!/bin/bash

OS=$(uname -s)

# zsh
echo "[WORKING] zsh"
sudo apt-get install -y zsh
# chsh -a /bin/zsh
echo "[FINISH] zsh"

# lazyvim dependencies
echo "[WORKING] unzip"
sudo apt-get install -y unzip
echo "[FINISH] unzip"

# # installs nvm (Node Version Manager)
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# # download and install Node.js (you may need to restart the terminal)
# nvm install 20

DOWNLOAD_FOLDER=/tmp/

# rustup + cargo
echo "[WORKING] rustup+cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
# source binary to prepare for the following cargo install
if [ -f $HOME/.cargo/env ]; then
  source "$HOME/.cargo/env"
fi
echo "[FINISH] rustup+cargo"

# fzf
echo "[WORKING] fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc
echo "[FINISH] fzf"

# delta (diff)
echo "[WORKING] git-delta"
cargo install -q git-delta
echo "[FINISH] git-delta"

# tldr
echo "[WORKING] tldr"
cargo install -q tlrc
echo "[FINISH] tldr"

# eza (ls)
echo "[WORKING] eza"
cargo install -q eza
echo "[FINISH] eza"

# zellij
echo "[WORKING] zellij"
cargo install -q --locked zellij
echo "[FINISH] zellij"

# zoxide (cd)
echo "[WORKING] zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "[FINISH] zoxide"

# pyenv
echo "[WORKING] pyenv"
curl https://pyenv.run | bash
echo "[FINISH] pyenv"

# uv
echo "[WORKING] uv"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo "[FINISH] uv"

# Install gh
if [ "$OS" = "Darwin" ]; then
  # bat (cat)
  echo "[WORKING] bat"
  brew install bat
  echo "[WORKING] bat"

  # fuck
  # brew install thefuck
elif [ "$OS" = "Linux" ]; then
  # bat (cat)
  echo "[WORKING] bat"
  sudo apt install -y bat
  mkdir -p ~/.local/bin
  ln -sf /usr/bin/batcat ~/.local/bin/bat
  echo "[WORKING] bat"

  # fuck
  # sudo apt-get update
  # sudo apt-get -y install python3-dev python3-pip python3-setuptools
  # pip3 install thefuck --user --break-system-packages
else
  echo "NOT MACOS/LINUX: abort package installation."
  exit
fi
