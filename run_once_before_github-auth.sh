#!/bin/bash

OS=$(uname -s)

# Install gh
if [ "$OS" = "Darwin" ]; then
	brew install gh
elif [ "$OS" = "Linux" ]; then
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
else
	echo "NOT MACOS/LINUX: abort gh installation and setup"
	exit
fi

# Auth
gh auth login -p https -w
