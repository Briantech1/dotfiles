#!/usr/bin/env bash

set -e

echo ">>> Installing dotfiles for user: $USER"

# Install zsh if needed
if ! command -v zsh >/dev/null 2>&1; then
    echo ">>> Installing zsh..."
    sudo apt update && sudo apt install zsh -y
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">>> Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Create symlinks
echo ">>> Linking dotfiles..."

ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
[ -f ~/.dotfiles/zsh/.p10k.zsh ] && ln -sf ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

mkdir -p ~/.ssh
ln -sf ~/.dotfiles/ssh/config ~/.ssh/config

echo ">>> Installing plugins..."

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 2>/dev/null || true

echo ">>> Changing default shell to zsh..."
chsh -s "$(command -v zsh)"

echo ">>> Dotfiles installation complete!"
