#!/usr/bin/env bash

# create an ssh key (with noinput and if create do not override)
cat /dev/zero | ssh-keygen -t rsa -b 2048 -q -N ''

# Run user on_setup script if any
if [[ -f .devcontainer/user/on_setup.sh ]]; then
  echo "Running user on_setup.sh script..."
  source .devcontainer/user/on_setup.sh
fi

# Install dependencies
pipenv sync --dev --python=3.8


# Run user post_setup script if any
if [[ -f .devcontainer/user/post_setup.sh ]]; then
  echo "Running user post_setup.sh script..."
  source .devcontainer/user/post_setup.sh
fi



# Show message that everything is ready
echo "Initial setup done..."