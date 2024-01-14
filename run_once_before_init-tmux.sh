#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y xclip

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

