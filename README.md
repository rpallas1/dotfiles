# rpallas1/dotfiles

A cross-platform (macOS, especially Apple Silicon & Intel) dotfiles setup for a modern, productive terminal environment.
This repo manages your shell, editor, terminal, and essential CLI tools via Homebrew, Stow, and robust configuration.

---

## Features

- **Homebrew-based package management**
  - Installs all essential CLI tools, fonts, and plugins for development.
  - Supports Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) macOS environments.
- **Zsh + Powerlevel10k prompt**
  - Fast, informative, and beautifully themed prompt.
  - Auto-detects Homebrew prefix for correct plugin/theme loading.
- **Neovim (Lua-based config)**
  - Modular plugin setup (LSP, formatting, completion, file explorer, statusline, etc.).
  - Uses Mason for language server and tool installation.
  - Modern plugins: Treesitter, nvim-cmp, lualine, nvim-tree, harpoon, etc.
- **Tmux and TPM**
  - Sensible defaults, with plugin manager auto-installer.
  - True color and prompt compatibility.
- **WezTerm**
  - Terminal emulator configuration included.
- **Stow-powered management**
  - Easily symlink configs to your HOME directory.
- **CLI utilities**
  - Includes eza, fzf, ripgrep, zoxide, lazygit, yazi, and more.
- **Font management**
  - Installs MesloLGS Nerd Font for prompt and icons compatibility.

---

## Installation

### 1. Clone the repository

```sh
git clone https://github.com/rpallas1/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the setup script

```sh
bin/setup.sh
```

**What this does:**

- Installs Homebrew if missing.
- Installs all packages and fonts from the `Brewfile`.
- Clones the dotfiles repo if needed.
- Runs `stow` to symlink configs.
- Installs Tmux Plugin Manager (TPM) and tmux plugins.

> **Note:**  
> The script will detect your Homebrew prefix for correct plugin/theme loading.  
> On Apple Silicon, ensure `/opt/homebrew/bin` is before `/usr/local/bin` in your `$PATH`.

### 3. Set your terminal font

For best results, set your terminal (WezTerm, iTerm2, etc.) to use **MesloLGS Nerd Font** (installed via the Brewfile).

---

## Environment Details

- **Shell:** [Zsh](https://www.zsh.org/) with [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **Editor:** [Neovim](https://neovim.io/) (Lua config, modular plugins, LSP)
- **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) (config included)
- **Multiplexer:** [tmux](https://github.com/tmux/tmux) with TPM
- **Package Manager:** [Homebrew](https://brew.sh/)
- **Dotfile management:** [Stow](https://www.gnu.org/software/stow/)

---

## Homebrew Packages

See [`Brewfile`](./Brewfile) for a full list of installed tools.

---

## Neovim Plugins

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (completion)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) (snippets)
- [mason.nvim](https://github.com/williamboman/mason.nvim) (LSP/tool installer)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) (file explorer)
- [lualine](https://github.com/nvim-lualine/lualine.nvim) (statusline)
- [harpoon](https://github.com/ThePrimeagen/harpoon) (file navigation)
- ...and many more (see the `nvim/.config/nvim/lua/ryan/plugins/` directory)

---

## Usage Tips

- **Zsh prompt:** Run `p10k configure` to adjust your Powerlevel10k prompt.
- **Neovim:** All plugins and tools are managed in Lua; update via Mason UI or `:Mason`.
- **Stow:** To re-link configs: `stow zsh tmux nvim wezterm yazi`
- **Font:** Ensure your terminal uses MesloLGS Nerd Font for icons.

---

## Troubleshooting

- **Missing C/C++ headers:**  
  Run `xcode-select --install` to ensure Xcode Command Line Tools are present.
- **Homebrew path issues:**  
  On Apple Silicon, ensure `/opt/homebrew/bin` is before `/usr/local/bin` in your `$PATH`.
- **Terminal icons/prompt look wrong:**  
  Set your terminal font to MesloLGS Nerd Font.
- **Neovim plugin errors:**  
  Run `:checkhealth` in Neovim for diagnostics.

---

## Contributing

PRs and suggestions welcome! Fork and open an issue or pull request.

---

## License

MIT

---
