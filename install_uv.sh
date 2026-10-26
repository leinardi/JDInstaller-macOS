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


# Installs Homebrew, then uv from Homebrew. `make` uses uv to run a pinned ansible-core (see
# .mk/ansible.mk), so the machine needs no Ansible of its own.

set -euo pipefail

# Function: Install Homebrew if missing, then load it into PATH
install_brew() {
  if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed."
  fi

  # Load Homebrew environment for this shell: a fresh install is not on PATH yet
  local brew_bin
  brew_bin=$(command -v brew || echo /opt/homebrew/bin/brew)
  eval "$("$brew_bin" shellenv)"
}

# Function: Install uv via Homebrew if missing
install_uv() {
  if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found. Installing via Homebrew..."
    brew update
    brew install uv
  else
    echo "uv is already installed."
  fi
}

main() {
  install_brew
  install_uv
}

main
