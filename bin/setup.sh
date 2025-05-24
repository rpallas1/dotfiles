#!/bin/bash

set -e

# -----------------------------
# ✅ STEP 1: Install Homebrew
# -----------------------------
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

# -----------------------------
# ✅ STEP 2: Install packages
# -----------------------------
echo "📦 Installing packages..."

brew install \
  git \
  stow \
  neovim \
  tmux \
  wezterm \
  yazi \
  zsh-autosuggestions \ 
  zsh-syntax-highlighting \
  zoxide \
  eza

# Optional: install other CLI tools you use regularly
# brew install ripgrep fzf bat fd zoxide starship

# -----------------------------
# ✅ STEP 3: Clone dotfiles repo
# -----------------------------
DOTFILES_DIR=~/dotfiles
REPO_URL="https://github.com/rpallas1/dotfiles.git" 

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📁 Cloning dotfiles repo..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "✅ dotfiles repo already exists."
fi

cd "$DOTFILES_DIR"

# -----------------------------
# ✅ STEP 4: Use stow for configs
# -----------------------------
echo "🔗 Running stow for dotfiles..."
stow zsh tmux nvim wezterm yazi

echo "🎉 Setup complete!"

# -----------------------------
# ✅ STEP 5: Set zsh as default shell
# -----------------------------
echo "🛠 Setting zsh as the default shell..."
if [ "$SHELL" != "/bin/zsh" ]; then
  chsh -s /bin/zsh
  echo "✅ zsh set as default shell. You may need to log out and back in for it to take effect."
else
  echo "ℹ️ zsh is already the default shell."
fi

echo "🎉 Setup complete!"
