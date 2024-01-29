#!/usr/bin/env bash

# Run user on_attach script if any
if [[ -f .devcontainer/user/on_attach.sh ]]; then
  echo "Running user on_attach.sh script..."
  source .devcontainer/user/on_attach.sh
fi

# Copy the template settings.json
if [[ ! -f .vscode/settings.json ]]; then
  echo "Copying the default vscode config..."
  cp .vscode/settings.json.template .vscode/settings.json
fi

# Copy the template .env
PROJECT_ENV_FILE_PATH=$PROJECT_DIR/effigeocode/settings/.env
if [[ ! -f "$PROJECT_ENV_FILE_PATH" ]]; then
  echo -e "Copying the default .env file...$PROJECT_ENV_FILE_PATH"
  cp "$PROJECT_DIR/.devcontainer/templates/django.env" "$PROJECT_ENV_FILE_PATH"

  # Prompt the user to open the file
  echo -e "\e[1;31mAn example .env file was created at: \e[1;37;4m$PROJECT_ENV_FILE_PATH\e[0m"
  echo -e "\e[1;31mMake sure to update it with the correct variables\e[0m"
fi

# Run user post_attach script if any
if [[ -f .devcontainer/user/post_attach.sh ]]; then
  echo "Running user post_attach.sh script..."
  source .devcontainer/user/post_attach.sh
fi

if [[ -f /usr/share/bash-completion/completions/git ]]; then
  echo "Enabling git tab autocomplete..."
  echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
fi

echo -e "\e[1;33mHappy coding ~~\e[0m"
