#!/bin/zsh

echo "Installing essential Zsh plugins..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh-My-Zsh not found. Please install it before running this script."
  exit 1
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions already installed, skipping..."
else
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "zsh-syntax-highlighting already installed, skipping..."
else
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

# zsh-history-substring-search
if [ -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]; then
  echo "zsh-history-substring-search already installed, skipping..."
else
  echo "Installing zsh-history-substring-search..."
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
fi

# you-should-use
if [ -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
  echo "you-should-use already installed, skipping..."
else
  echo "Installing you-should-use..."
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM}/plugins/you-should-use
fi

# Reload Zsh configuration
echo "Configuring plugins in .zshrc..."

if grep -q "plugins=(" "$HOME/.zshrc"; then
  sed -i 's/plugins=(\(.*\))/plugins=(\1 z copypath copyfile copybuffer sudo zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search you-should-use)/' "$HOME/.zshrc"
else
  echo 'plugins=(git z copypath copyfile copybuffer sudo zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search you-should-use)' >> "$HOME/.zshrc"
fi

echo "Adding additional plugin configuration to .zshrc..."
cat << 'EOF' >> "$HOME/.zshrc"

# >>> plugins configuration >>>
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=(bg=none,fg=magenta,bold)

# you-should-use
export YSU_MESSAGE_POSITION="after"
# <<< plugins configuration <<<
EOF

echo "All plugins installed and configured! Please restart your terminal or log out and back in to apply changes."
