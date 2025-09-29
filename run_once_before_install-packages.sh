#!/bin/bash

OS=$(uname -s)

if [ "$OS" = "Linux" ]; then
  # zsh
  # echo "[WORKING] zsh"
  # sudo apt-get install -y zsh
  # chsh -a /bin/zsh
  # echo "[FINISH] zsh"

  # lazyvim dependencies
  echo "[WORKING] unzip"
  sudo apt-get install -y unzip
  echo "[FINISH] unzip"
fi

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

# cargo-install for installing rust binaries
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
# ensure .cargo/bin is in the PATH.
export PATH=$HOME/.cargo/bin:$PATH

# rigrep
echo "[WORKING] ripgrep"
cargo binstall ripgrep -y --locked
echo "[FINISH] ripgrep"

# fd-find
echo "[WORKING] fd-find"
cargo binstall fd-find -y --locked
echo "[FINISH] fd-find"

# delta (diff)
echo "[WORKING] git-delta"
cargo binstall git-delta -y --locked
echo "[FINISH] git-delta"

# tldr
echo "[WORKING] tldr"
cargo binstall tldr -y --locked
echo "[FINISH] tldr"

# eza (ls)
echo "[WORKING] eza"
cargo binstall eza -y --locked
echo "[FINISH] eza"

# zellij
echo "[WORKING] zellij"
cargo binstall zellij -y --locked
echo "[FINISH] zellij"

# zoxide (cd)
echo "[WORKING] zoxide"
cargo binstall zoxide -y --locked
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "[FINISH] zoxide"

# pyenv
# echo "[WORKING] pyenv"
# curl https://pyenv.run | bash
# echo "[FINISH] pyenv"

# uv
echo "[WORKING] uv"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo "[FINISH] uv"

# zsh fzf-tab completion plugin
echo "[WORKING] fzf-tab (zsh plugin)"
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
echo "[FINISH] fzf-tab (zsh plugin)"

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
  cargo binstall bat -y --locked
  # sudo apt install -y bat
  # mkdir -p ~/.local/bin
  # ln -sf /usr/bin/batcat ~/.local/bin/bat
  echo "[WORKING] bat"

  # fuck
  # sudo apt-get update
  # sudo apt-get -y install python3-dev python3-pip python3-setuptools
  # pip3 install thefuck --user --break-system-packages
else
  echo "NOT MACOS/LINUX: abort package installation."
  exit
fi
