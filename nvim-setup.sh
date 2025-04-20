#!/usr/bin/env bash

set -e

echo "Starting Neovim configuration setup..."

# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
  if command_exists apt; then
    PKG_MANAGER="apt"
  elif command_exists dnf; then
    PKG_MANAGER="dnf"
  elif command_exists pacman; then
    PKG_MANAGER="pacman"
  else
    echo "Unsupported Linux package manager. Please install dependencies manually."
    exit 1
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
  if ! command_exists brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  PKG_MANAGER="brew"
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# Install dependencies based on OS
install_dependencies() {
  echo "Installing dependencies..."
  
  if [[ $OS == "linux" ]]; then
    if [[ $PKG_MANAGER == "apt" ]]; then
      sudo apt update
      sudo apt install -y git curl make gcc g++ ripgrep fd-find nodejs npm python3 python3-pip unzip
      # Create symlink for fd if needed
      if ! command_exists fd && command_exists fdfind; then
        sudo ln -s $(which fdfind) /usr/local/bin/fd
      fi
    elif [[ $PKG_MANAGER == "dnf" ]]; then
      sudo dnf install -y git curl make gcc ripgrep fd-find nodejs npm python3 python3-pip
    elif [[ $PKG_MANAGER == "pacman" ]]; then
      sudo pacman -Sy git curl make gcc ripgrep fd nodejs npm python python-pip
    fi
  elif [[ $OS == "macos" ]]; then
    brew update
    brew install neovim git curl make ripgrep fd node python jq
  fi
  
  # Install Neovim if not already installed
  if ! command_exists nvim; then
    echo "Installing Neovim..."
    if [[ $OS == "linux" ]]; then
      if [[ $PKG_MANAGER == "apt" ]]; then
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt update
        sudo apt install -y neovim
      elif [[ $PKG_MANAGER == "dnf" ]]; then
        sudo dnf install -y neovim
      elif [[ $PKG_MANAGER == "pacman" ]]; then
        sudo pacman -S neovim
      fi
    elif [[ $OS == "macos" ]]; then
      brew install neovim
    fi
  else
    echo "Neovim is already installed."
  fi
  
  # Install global npm packages
  echo "Installing npm packages..."
  npm install -g prettier eslint typescript-language-server vscode-langservers-extracted tailwindcss-language-server @tailwindcss/language-server typescript typescript-language-server pyright dockerfile-language-server-nodejs sql-language-server terraform-ls yaml-language-server cspell
  
  # Install Python packages
  echo "Installing Python packages..."
  pip3 install ruff python-lsp-server black
  
  # Install stylua
  if ! command_exists stylua; then
    echo "Installing stylua..."
    if [[ $OS == "macos" ]]; then
      brew install stylua
    else
      cargo install stylua || echo "Stylua installation failed. Please install manually."
    fi
  fi
  
  # Install shfmt
  if ! command_exists shfmt; then
    echo "Installing shfmt..."
    if [[ $OS == "macos" ]]; then
      brew install shfmt
    else
      GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest || echo "shfmt installation failed. Please install manually."
    fi
  fi
}

# Setup Neovim configuration
setup_neovim() {
  echo "Setting up Neovim configuration..."
  
  # Backup existing configuration if it exists
  NVIM_CONFIG_DIR="$HOME/.config/nvim"
  if [[ -d "$NVIM_CONFIG_DIR" ]]; then
    echo "Backing up existing Neovim configuration..."
    mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
  fi
  
  # Create config directory if it doesn't exist
  mkdir -p "$NVIM_CONFIG_DIR"
  
  # Clone configuration from GitHub
  echo "Cloning configuration repository..."
  git clone https://github.com/cRhettiarachchi/nvim-config.git "$NVIM_CONFIG_DIR"
  
  echo "Neovim configuration has been set up successfully!"
}

# Main execution
install_dependencies
setup_neovim

echo "Setup complete! Starting Neovim to install plugins..."
echo "Note: The first run might take a few minutes as plugins are being installed."
echo "Press any key to continue..."
read -n 1

# Launch Neovim
nvim