# Auto-start ZSH if inside Bash (for remote servers)
if [ -n "$BASH_VERSION" ]; then
    exec zsh
fi

# Oh My Zsh base directory
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Aliases
alias sshmenu="~/.ssh/menu"
alias ssmenu="~/.ssh/menu"

# Add your custom aliases below
# alias ll='ls -lah'
