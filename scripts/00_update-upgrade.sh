#!/bin/bash

# Create the script with content
echo '#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove -y' | sudo tee /usr/bin/update > /dev/null

# Make the script executable
sudo chmod +x /usr/bin/update

# Run the script
update