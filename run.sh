#!/bin/bash

# Navigate to the scripts directory
cd "$(dirname "$0")/scripts"

# Execute all scripts in the scripts directory
for script in *.sh; do
  if [ -x "$script" ]; then
    bash ./"$script"
  else
    echo "Skipping $script as it is not executable."
  fi
done