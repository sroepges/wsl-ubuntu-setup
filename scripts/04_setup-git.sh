#!/bin/bash

# Prompt the user for their Git credentials
read -p "Enter your Git user name: " git_username
read -p "Enter your Git user email: " git_email

# Add the Git credentials to the global config file
git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "Git global configuration has been set:"
git config --global --list