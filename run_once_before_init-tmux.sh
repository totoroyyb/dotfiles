#!/bin/bash

# Install xclip for clipboard support
sudo apt-get update -y
sudo apt-get install -y xclip

# Install tmux config
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

# Restart tmux server
tmux kill-server

