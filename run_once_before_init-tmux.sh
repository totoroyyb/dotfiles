#!/bin/bash

# System packages (xclip, unzip) are installed via `mise run setup-system`,
# not here -- see ~/.config/mise/config.toml. This script only bootstraps the
# gpakosz .tmux config framework.

# Install tmux config
if [ -d "$HOME/.tmux" ]; then
    echo "tmux dir already exists. abort init tmux config installation"
else
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    
    # Restart tmux server
    # tmux kill-server > /dev/null 2>&1
fi


