#!/usr/bin/env bash
set -euo pipefail

# Function: Install Homebrew if missing, then load it into PATH
install_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi

  # Load Homebrew environment for this shell
  if command -v brew >/dev/null 2>&1; then
    eval "$($(command -v brew) shellenv)"
  fi
}

# Function: Install Ansible via Homebrew if missing
install_ansible() {
  if ! command -v ansible >/dev/null 2>&1; then
    echo "Ansible not found. Installing via Homebrew..."
    brew update
    brew install ansible
  else
    echo "Ansible is already installed."
  fi
}

# Function: Install Ansible collections from requirements.yaml
install_requirements() {
  echo "Installing Ansible collections from requirements.yaml..."
  ansible-galaxy collection install -r requirements.yaml
}

# Function: Print final instructions
print_instructions() {
  cat <<-EOF

  ==================================================
   Ansible installation and setup completed!
  ==================================================

  Next steps:

  1. Customize your variables (e.g. in inventory/group_vars/all.yaml)
  2. Run the macOS playbook:

       ansible-playbook playbooks/macos-setup.yaml --ask-become-pass

     The --ask-become-pass flag will prompt you for your sudo password.

  ==================================================

EOF
}

main() {
  install_brew
  install_ansible
  install_requirements
  print_instructions
}

main
