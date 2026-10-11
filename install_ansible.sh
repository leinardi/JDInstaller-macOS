#!/usr/bin/env bash
#
# Copyright 2025 Roberto Leinardi.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

# Function: Install Ansible collections from requirements.yml
install_requirements() {
  echo "Installing Ansible collections from requirements.yml..."
  ansible-galaxy collection install -r requirements.yml
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
