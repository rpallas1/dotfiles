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
# ✅ STEP 2: Install brew packages
# -----------------------------
brew bundle --file=~/dotfiles/Brewfile
echo "✅ Brew packages installed."

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
# ✅ STEP 5: Install TPM (Tmux Plugin Manager) 
# -----------------------------
TPM_DIR=~/.tmux/plugins/tpm
if [ ! -d "$TPM_DIR" ]; then
  echo "📦 Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM already installed."
fi

# Install tmux plugins automatically
if command -v tmux &>/dev/null; then
  echo "🔌 Installing tmux plugins via TPM..."
  tmux new-session -d -s __tpm_install 'sleep 1'
  "$TPM_DIR/bin/install_plugins"
  tmux kill-session -t __tpm_install
  echo "✅ tmux plugins installed."
else
  echo "⚠️ tmux is not installed, skipping plugin installation."
fi

# -----------------------------
# ✅ STEP 6: Set zsh as default shell
# -----------------------------
echo "🛠 Setting zsh as the default shell..."
if [ "$SHELL" != "/bin/zsh" ]; then
  chsh -s /bin/zsh
  echo "✅ zsh set as default shell. You may need to log out and back in for it to take effect."
else
  echo "ℹ️ zsh is already the default shell."
fi

echo "🎉 Setup complete!"
