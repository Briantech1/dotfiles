#!/usr/bin/env bash
set -e

USER_SHELL=$(command -v zsh || true)

echo ">>> Installing dotfiles for user: $USER"

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PKG_INSTALL="apt install -y"
elif command -v apt-get >/dev/null 2>&1; then
    PKG_INSTALL="apt-get install -y"
else
    echo ">>> Unsupported system. Install zsh manually."
    exit 1
fi

# Detect whether sudo exists
if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
else
    SUDO=""
fi

# Install zsh if needed
if [ -z "$USER_SHELL" ]; then
    echo ">>> Installing zsh..."
    $SUDO $PKG_INSTALL zsh
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">>> Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Create symlinks
echo ">>> Linking dotfiles..."

ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
[ -f ~/.dotfiles/zsh/.p10k.zsh ] && ln -sf ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

mkdir -p ~/.ssh
ln -sf ~/.dotfiles/ssh/config ~/.ssh/config

# Install plugins
echo ">>> Installing plugins..."

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 2>/dev/null || true

# Change shell (skip if on Proxmox root)
if [ "$USER" != "root" ]; then
    echo ">>> Changing default shell to zsh..."
    chsh -s "$(command -v zsh)" || true
fi

echo ">>> Dotfiles installation complete!"

