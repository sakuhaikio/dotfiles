# Dotfiles

Personal Bash, Git and Readline configuration for Linux and WSL.

## Features

- Modular Bash configuration
- Custom aliases and shell functions
- Environment variables
- fzf integration
- Readline configuration
- Git configuration
- Automated `.bashrc` setup
- WSL integration

## Repository Structure

```text
dotfiles/
├── README.md
├── bash/
│   └── install.sh
├── git/
│   └── install.sh
├── readline/
│   └── install.sh
└── setup_bashrc.sh
```

Configuration files beginning with `.` are hidden and may not appear in directory listings by default.

## Installation

Clone the repository:

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

### Bash

Install the Bash configuration:

```bash
./bash/install.sh
```

Configure `.bashrc`:

```bash
./setup_bashrc.sh
```

The setup script adds the necessary source statements to `.bashrc` if they are not already present.

It also configures Windows Terminal integration when running under WSL.

### Readline

Install the Readline configuration:

```bash
./readline/install.sh
```

### Git

Install the Git configuration:

```bash
./git/install.sh
```

If your Git identity is not configured, set it using:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Components

### Bash

The Bash configuration is organized into separate files:

- `.bash_aliases` — Custom command aliases
- `.bash_exports` — Environment variables
- `.bash_functions` — Custom shell functions
- `.bash_plugins` — Shell plugins and integrations

The `setup_bashrc.sh` script ensures that the custom configuration files are loaded by Bash.

### Readline

Provides custom GNU Readline settings for Bash and other compatible command-line applications.

### Git

Provides a custom global Git configuration.

### WSL Integration

When running under WSL, the Bash setup configures terminal integration to communicate the current working directory to Windows Terminal.

## License

This repository is released under the MIT License.
