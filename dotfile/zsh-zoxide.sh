#!/bin/zsh

echo "Installing Zsh plugins(zoxide)..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh-My-Zsh not found. Please install it before running this script."
  exit 1
fi

echo "Installing zoxide..."
sudo apt install -y zoxide fzf

echo "Adding additional plugin configuration to .zshrc..."
cat << 'EOF' >> "$HOME/.zshrc"

# Alias for cd replacement: zoxide
eval "$(zoxide init --cmd cd zsh)"
alias cd=z
EOF

echo "Installation complete! Please restart your terminal or log out and back in to apply the changes."
