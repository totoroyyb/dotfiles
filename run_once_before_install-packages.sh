#!/bin/bash

OS=$(uname -s)

# lazyvim dependencies
sudo apt-get install -y unzip

# # installs nvm (Node Version Manager)
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# # download and install Node.js (you may need to restart the terminal)
# nvm install 20

DOWNLOAD_FOLDER=/tmp/

# rustup + cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# delta (diff)
cargo install -q git-delta

# tldr
cargo install -q tlrc

# eza (ls)
cargo install eza

# zoxide (cd)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# pyenv
curl https://pyenv.run | bash

# Install gh
if [ "$OS" = "Darwin" ]; then
  # bat (cat)
  brew install bat

  # fuck
  # brew install thefuck
elif [ "$OS" = "Linux" ]; then
  # bat (cat)
  sudo apt install bat
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat

  # fuck
  # sudo apt-get update
  # sudo apt-get -y install python3-dev python3-pip python3-setuptools
  # pip3 install thefuck --user --break-system-packages
else
  echo "NOT MACOS/LINUX: abort package installation."
  exit
fi
