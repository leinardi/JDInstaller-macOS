<!-- [![Ubuntu test](https://github.com/leinardi/JDInstaller/actions/workflows/ubuntu-test.yaml/badge.svg?branch=release)](https://github.com/leinardi/JDInstaller-macOS/actions/workflows/ubuntu-test.yaml) [![CI release](https://github.com/leinardi/JDInstaller-macOS/actions/workflows/ci.yaml/badge.svg?branch=release)](https://github.com/leinardi/JDInstaller-macOS/actions/workflows/ci.yaml) -->

# JDInstaller (macOS Edition)

This Ansible playbook automates the setup of a fresh **macOS** installation according to my personal preferences. It is based on the
original [JDInstaller for Ubuntu](https://github.com/leinardi/JDInstaller), but repurposed for macOS.

The configuration is very **opinionated** and tailored for **Linux users who are forced to use macOS at work**, like me. I normally use GNOME and Linux, and
macOS has very different defaults and shortcuts that interrupt my muscle memory. This setup attempts to fix that by making macOS behave **as close to GNOME as
possible**.

Some examples:

- Remaps **Ctrl**, **Alt**, and **Super** keys so shortcuts like `Ctrl+C/V` work like in Linux
- Changes the **Alt+Tab** experience
- Disables **Mission Control**, **long-press character selection**, and other macOS behaviors
- Configures **function keys** and common preferences

This may seem blasphemous to seasoned Mac users but, if you're a Linux person trying to survive macOS, this setup might feel like home.

It can also be helpful for anyone looking to automate macOS configuration (e.g. installing Homebrew formulae, setting system defaults, etc.).

---

## Table of Contents

- [How to Use](#how-to-use)
    - [Install Prerequisites](#install-prerequisites)
    - [Download the Repository](#download-the-repository)
    - [Run the Playbook](#run-the-playbook)
    - [Run Single Roles](#run-single-roles)
- [Roles](#roles)
- [Contributions](#contributions)
- [Acknowledgements](#acknowledgements)

---

## How to Use

### Install Prerequisites

Before running the playbook, make sure you have:

- macOS 15 or newer (Apple Silicon)
- Xcode command line tools (`xcode-select --install`)
- Git and Bash (installed by default)
- [Homebrew](https://brew.sh) (installed automatically by the setup script)

### Download the Repository

Clone this repository:

```bash
git clone https://github.com/leinardi/JDInstaller-macOS.git
cd JDInstaller-macOS
````

### Run the Playbook

Use the setup script to install Homebrew, Ansible, and required collections:

```bash
./macos-setup.sh
```

Once Ansible is installed, you can run the main playbook:

```bash
ansible-playbook playbooks/macos-setup.yaml --ask-become-pass
```

This command will:

* Prompt for your sudo password
* Run only the roles you’ve enabled in `inventory/group_vars/all.yaml`

### Run Single Roles

Each role is tagged. To run just one role:

```bash
ansible-playbook playbooks/macos-setup.yaml --ask-become-pass --tags firefox
```

To run multiple:

```bash
ansible-playbook playbooks/macos-setup.yaml --ask-become-pass --tags "homebrew,common,development"
```

---

## Roles

Each task is broken into reusable Ansible roles, all located under `roles/`. You can enable or disable any role in `inventory/group_vars/all.yaml` using the
`*_enabled` flags.

Examples of included roles:

* `homebrew`: Installs Homebrew and essential formulae
* `common`: Installs CLI tools like `tree`, `git`, `vim`
* `firefox`, `vlc`, etc.: Install GUI applications via Homebrew Cask
* `desktop_and_dock`: Customizes Dock, Mission Control, and Spaces
* `keyboard`, `mouse`, `finder`: System UI/UX preferences
* `file_associations`: Uses [`infat`](https://github.com/philocalyst/infat) to configure default apps

---

## Contributions

Bug fixes and improvements are welcome!

Please note:

* This repo is very opinionated. I may not accept changes that go against its purpose.
* You’re welcome to contribute **additional roles**, but they must be **disabled by default**.

**Before opening a pull request**, open an issue to discuss what you want to add.

This project uses [pre-commit](https://pre-commit.com/) for basic checks:

```bash
brew install pre-commit
make install-pre-commit
make check
```

---

## Acknowledgements

* Based on [JDInstaller for Ubuntu](https://github.com/leinardi/JDInstaller)
