# Dotfiles

Personal Bash, Git and Readline configuration for Linux and WSL.

## Features

* Modular Bash configuration
* Custom aliases
* Custom shell functions
* Environment variables
* fzf integration
* Readline configuration
* Git configuration

## Repository Structure

```text
dotfiles/
├── bash/
│   ├── .bash_aliases
│   ├── .bash_exports
│   ├── .bash_functions
│   ├── .bash_plugins
│   └── install.sh
├── git/
│   ├── .gitconfig
│   └── install.sh
├── readline/
│   ├── .inputrc
│   └── install.sh
└── README.md
```

## Installation

Install the Bash configuration:

```bash
~/dotfiles/bash/install.sh
```

Install the Readline configuration:

```bash
~/dotfiles/readline/install.sh
```

Install the Git configuration:

```bash
~/dotfiles/git/install.sh "Your Name" "your.email@example.com"
```

## Components

### Bash

Installs symbolic links for:

* `.bash_aliases`
* `.bash_exports`
* `.bash_functions`
* `.bash_plugins`

### Readline

Installs a symbolic link for `.inputrc`, providing custom GNU Readline settings for Bash and other compatible command-line applications.

### Git

Copies `.gitconfig` to the home directory and configures the Git user name and email supplied as arguments.

## License

This repository is released under the MIT License.
