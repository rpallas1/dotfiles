#!/bin/bash
set -e

# Detect Homebrew prefix directly, not relying on .zshrc
if [[ -d /opt/homebrew ]]; then
  HOMEBREW_PREFIX=/opt/homebrew
elif [[ -d /usr/local ]]; then
  HOMEBREW_PREFIX=/usr/local
else
  HOMEBREW_PREFIX=""
fi

# Add to PATH for this script's execution
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
  export PATH="$HOMEBREW_PREFIX/sbin:$PATH"
fi

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
echo "🍺 Installing Brew packages..."

set +e  # Disable immediate exit on error just for this step
brew bundle --file=~/dotfiles/Brewfile
BUNDLE_EXIT_CODE=$?
set -e  # Re-enable exit-on-error for later steps

if [ $BUNDLE_EXIT_CODE -ne 0 ]; then
  echo "⚠️  brew bundle failed to install all packages from your Brewfile."
  echo "Check the output above for errors (e.g. conflicting taps, missing formulas, etc)."
  echo "You may want to fix the Brewfile, run 'brew doctor', or manually install missing packages."

  read -p "Do you want to continue with the rest of the setup anyway? (y/N): " CONTINUE
  if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
    echo "Exiting setup. You can fix the Brewfile and re-run this script."
    exit 1
  fi
fi

echo "✅ Brew packages step finished."

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

echo ""
echo "=============================================="
echo " 🚀 NEXT STEPS"
echo "=============================================="
echo ""
echo "1. ♻️  Restart your terminal, open WezTerm, or reload Zsh to activate all changes:"
echo "   exec zsh"
echo ""
echo "2. 🧩 Install Neovim plugins (LazyVim):"
echo "   Open Neovim with: nvim"
echo "   On first launch, plugins will sync automatically."
echo "   Or run manually inside Neovim: :Lazy sync"
echo ""
echo "3. 🔌 Install Tmux plugins:"
echo "   Start tmux: tmux"
echo "   Then press the prefix key (Ctrl+a), then capital 'I' (Shift+i):"
echo "     Ctrl + a, then I"
echo ""
echo "   This will install all your tmux plugins."
echo ""
echo "✨ You’re all set! Enjoy your new terminal environment."
echo ""
