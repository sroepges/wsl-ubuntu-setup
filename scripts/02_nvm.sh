#!/bin/bash

# Based of:
# https://stackoverflow.com/questions/37189674/command-to-download-latest-version-of-nvm

# Get latest nvm version
nvm_latest_version() {
   basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/nvm-sh/nvm/releases/latest)
}
latest_version_number=$(nvm_latest_version "${nvm_string}");

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/${latest_version_number}/install.sh | bash

# Source zsh conf
source ~/.zshrc

# Install node lts
nvm install --lts

# Enable corepack
corepack enable