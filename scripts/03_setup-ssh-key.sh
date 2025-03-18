#!/bin/bash

# Prompt the user for ssh key comment
read -p "Enter your ssh key comment (email): " comment

# Generate an SSH key with the provided comment
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "$comment"

# Add the SSH key to the SSH agent
ssh-add ~/.ssh/id_ed25519

# Setup Keychain
sudo apt install keychain -y

# Append Keychain configuration to .zshrc
echo '
# Keychain
/usr/bin/keychain $HOME/.ssh/id_ed25519
source $HOME/.keychain/$HOST-sh
' >> ~/.zshrc

# Source zsh conf
source ~/.zshrc