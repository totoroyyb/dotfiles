#!/bin/bash

OS=$(uname -s)

DOWNLOAD_FOLDER=/tmp/

# rustup + cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# delta
cargo install git-delta

# Install gh
if [ "$OS" = "Darwin" ]; then
  # bat
  brew install bat
elif [ "$OS" = "Linux" ]; then
  # bat
  sudo apt install bat
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
else
  echo "NOT MACOS/LINUX: abort package installation."
  exit
fi
