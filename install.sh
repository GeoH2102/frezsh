#!/bin/bash
set -e

echo "==> Installing modern zsh toolchain for Ubuntu"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }

# Install apt packages
info "Installing packages via apt..."
sudo apt update
sudo apt install -y zsh fzf fd-find bat ripgrep git curl wget

# fd is installed as 'fdfind' on Ubuntu, create symlink
if [ ! -f ~/.local/bin/fd ] && command -v fdfind &> /dev/null; then
    mkdir -p ~/.local/bin
    ln -sf $(which fdfind) ~/.local/bin/fd
    success "Created fd symlink"
fi

# bat is installed as 'batcat' on Ubuntu, create symlink
if [ ! -f ~/.local/bin/bat ] && command -v batcat &> /dev/null; then
    mkdir -p ~/.local/bin
    ln -sf $(which batcat) ~/.local/bin/bat
    success "Created bat symlink"
fi

# Install eza (modern ls)
if ! command -v eza &> /dev/null; then
    info "Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    success "eza installed"
fi

# Install Starship prompt
if ! command -v starship &> /dev/null; then
    info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    success "Starship installed"
fi

# Install zoxide
if ! command -v zoxide &> /dev/null; then
    info "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    success "zoxide installed"
fi

# Install Atuin (shell history)
if ! command -v atuin &> /dev/null; then
    info "Installing Atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    success "Atuin installed"
fi

# Install chezmoi
if ! command -v chezmoi &> /dev/null; then
    info "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
    success "chezmoi installed"
fi

# Install zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    info "Installing zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    success "zinit installed"
fi

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

success "All tools installed!"
echo ""
echo "Next steps:"
echo "  1. Run: chsh -s \$(which zsh)  # Set zsh as default shell"
echo "  2. Log out and back in"
echo "  3. Copy dotfiles or run chezmoi init"
