#!/bin/bash

function echo_to_file {
    local line="$1"
    local file="$2"

    if grep -Fxq "$line" "$file"; then
	echo "Found $line in file: $file"
    else
	echo $line >> $file
    fi
}

BASH_CONF_PATH="$HOME/.bash_profile"
BASH_RC_PATH="$HOME/.bashrc"
ZSH_CONF_PATH="$HOME/.zshrc"

function echo_to_conf {
    echo_to_file "$1" "$BASH_CONF_PATH"
    echo_to_file "$1" "$BASH_RC_PATH"
    echo_to_file "$1" "$ZSH_CONF_PATH"
}

EDITOR_SETUP_CMD="export EDITOR='vim'"
PATH_SETUP_CMD="export PATH=$PATH:$HOME/bin/:$HOME/.bin/:$HOME/.local/bin/"

DISPLAY_ENV="$(echo $DISPLAY)"
DISPLAY_CMD="export DISPLAY=\"$DISPLAY_ENV\""

echo_to_conf "$DISPLAY_CMD"

# echo_to_conf "$EDITOR_SETUP_CMD" 
# echo_to_conf "$PATH_SETUP_CMD" 

