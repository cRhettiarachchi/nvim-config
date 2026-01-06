# Neovim Configuration

A modern, feature-rich Neovim configuration focused on TypeScript/JavaScript development with Vue.js support.

![Neovim](https://img.shields.io/badge/Neovim-0.11+-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## ✨ Features

- 🚀 **Fast startup** with lazy loading via [lazy.nvim](https://github.com/folke/lazy.nvim)
- 📝 **Smart autocompletion** using [blink.cmp](https://github.com/saghen/blink.cmp)
- 🎨 **Beautiful UI** with Kanagawa Dragon colorscheme
- 🔍 **Powerful fuzzy finding** with Telescope and Snacks
- 🌳 **Advanced LSP** support for TypeScript, Vue, and more
- ✅ **Code formatting** on save with Conform
- 🎯 **Treesitter** syntax highlighting and code folding
- 📦 **Git integration** with LazyGit, Diffview, and Gitsigns
- 🧪 **Testing support** with Neotest
- 🎭 **Multiple file explorers** (Oil, Snacks, Neotree)

## 📋 Requirements

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0 (for LSP servers)
- **Rust** toolchain (for blink.cmp and codebook-lsp)
- **A Nerd Font** (recommended: [JetBrains Mono](https://www.nerdfonts.com/))

### Optional Dependencies

- [ripgrep](https://github.com/BurntSushi/ripgrep) - for Telescope live grep
- [fd](https://github.com/sharkdp/fd) - for faster file finding
- [lazygit](https://github.com/jesseduffield/lazygit) - for git TUI

## 🚀 Installation

### Backup Existing Config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Clone This Config

```bash
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim
```

### Install Dependencies (macOS)

```bash
# Using Homebrew
brew install neovim ripgrep fd lazygit node

# Install Rust (for blink.cmp)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install nightly Rust (for codebook-lsp)
rustup toolchain install nightly

# Install codebook-lsp
cargo +nightly install codebook-lsp
```

### First Launch

```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin version lock file
├── stylua.toml                # Lua formatter configuration
├── lua/
│   ├── config/
│   │   └── lazy.lua           # Lazy.nvim bootstrap and setup
│   ├── core/
│   │   ├── keymaps.lua        # Global keymaps
│   │   └── options.lua        # Vim options and settings
│   ├── plugins/
│   │   ├── init.lua           # UI plugins (colorscheme, which-key)
│   │   ├── lsp/               # LSP-related plugins
│   │   │   ├── lsp.lua        # LSP file operations, lazydev
│   │   │   └── mason.lua      # Mason LSP/formatter installer
│   │   ├── blink-cmp.lua      # Completion engine
│   │   ├── treesitter.lua     # Syntax highlighting & folding
│   │   ├── telescope.lua      # Fuzzy finder
│   │   ├── snacks.lua         # Multi-purpose plugin suite
│   │   ├── conform.lua        # Code formatting
│   │   ├── oil.lua            # File explorer
│   │   ├── lazygit.lua        # Git integration
│   │   ├── harpoon.lua        # Quick file navigation
│   │   ├── neo-test.lua       # Testing framework
│   │   ├── neo-clip.lua       # Clipboard manager
│   │   ├── comment.lua        # Comment toggling
│   │   ├── diffview.lua       # Git diff viewer
│   │   ├── lualine.lua        # Statusline
│   │   ├── colorizer.lua      # Color highlighter
│   │   ├── auto-pairs.lua     # Auto-close brackets
│   │   └── misc.lua           # Standalone plugins
│   └── lsp.lua                # LSP keymaps and configuration
└── after/lsp/
    ├── vtsls.lua              # TypeScript/Vue LSP config
    └── vue_ls.lua             # Vue language server config
```

## ⌨️ Key Mappings

### Leader Keys

- `<Space>` - Leader key
- `\` - Local leader key

### General

| Key          | Mode | Action                 |
| ------------ | ---- | ---------------------- |
| `<C-s>`      | N, V | Save file              |
| `<leader>v`  | N    | Vertical split         |
| `<leader>h`  | N    | Horizontal split       |
| `<leader>me` | N    | Make splits equal size |

### File Navigation (Telescope)

| Key                | Action                      |
| ------------------ | --------------------------- |
| `<leader>sf`       | Find files                  |
| `<leader>sg`       | Live grep                   |
| `<leader>sb`       | Search buffers              |
| `<leader>sh`       | Search help                 |
| `<leader>sk`       | Search keymaps              |
| `<leader>sw`       | Search word under cursor    |
| `<leader>s/`       | Search in open files        |
| `<leader>/`        | Fuzzy search current buffer |
| `<leader><leader>` | Switch buffers              |
| `<leader>gs`       | Git status                  |

### File Navigation (Snacks)

| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>sf` | Find files              |
| `<leader>sg` | Grep with word boundary |
| `<leader>sw` | Grep word under cursor  |
| `<leader>sr` | Resume last search      |
| `<leader>sb` | Search buffer lines     |
| `<leader>sd` | Diagnostics             |
| `<leader>sD` | Buffer diagnostics      |
| `<leader>sk` | Keymaps                 |
| `<leader>fp` | Projects                |
| `<leader>n`  | Notifications history   |
| `<leader>.`  | Scratch buffer          |
| `<leader>S`  | Select scratch buffer   |
| `<leader>:`  | Command history         |

### LSP

| Key          | Mode | Action              |
| ------------ | ---- | ------------------- |
| `gd`         | N    | Go to definition    |
| `gD`         | N    | Go to declaration   |
| `gR`         | N    | References          |
| `gi`         | N    | Implementations     |
| `gt`         | N    | Type definitions    |
| `K`          | N    | Hover documentation |
| `<leader>ca` | N, V | Code actions        |
| `<leader>rn` | N    | Rename symbol       |
| `<leader>d`  | N    | Line diagnostics    |
| `<leader>D`  | N    | Buffer diagnostics  |
| `[d`         | N    | Previous diagnostic |
| `]d`         | N    | Next diagnostic     |
| `<leader>rs` | N    | Restart LSP         |

### Git

| Key          | Action       |
| ------------ | ------------ |
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Git branches |
| `<leader>gl` | Git log      |
| `<leader>gL` | Git log line |
| `<leader>gs` | Git status   |
| `<leader>gf` | Git log file |

### Code Folding

| Key  | Action          |
| ---- | --------------- |
| `za` | Toggle fold     |
| `zc` | Close fold      |
| `zo` | Open fold       |
| `zM` | Close all folds |
| `zR` | Open all folds  |

### Terminal

| Key     | Action          |
| ------- | --------------- |
| `<C-_>` | Toggle terminal |

### Miscellaneous

| Key          | Action             |
| ------------ | ------------------ |
| `<leader>mm` | Toggle Zen zoom    |
| `<leader>uh` | Toggle inlay hints |

### Visual Mode

| Key | Action                          |
| --- | ------------------------------- |
| `p` | Paste without yanking selection |

## 🔧 Language Support

### TypeScript/JavaScript

- **LSP**: vtsls (faster alternative to tsserver)
- **Formatting**: Prettier (via prettierd)
- **Linting**: ESLint (via eslint_d)
- **Features**:
  - Auto-import updates on file move
  - Function call completions
  - Inlay hints for types
  - Vue TypeScript plugin integration

### Vue.js

- **LSP**: vue_ls + vtsls (hybrid mode)
- **Formatting**: Prettier
- **Features**:
  - Full TypeScript support in `<script>` blocks
  - Template syntax highlighting
  - Component auto-completion

### Lua

- **LSP**: lua_ls
- **Formatting**: stylua
- **Features**:
  - Neovim Lua API completion
  - LazyDev for plugin development

### Other Languages

- **HTML/CSS**: html, cssls
- **Tailwind**: tailwindcss
- **Python**: (parsers available, LSP not configured)
- **Rust**: (parsers available, LSP not configured)

## 🎨 Customization

### Change Colorscheme

Edit `lua/plugins/init.lua`:

```lua
vim.cmd "colorscheme kanagawa-wave"  -- or kanagawa-lotus
```

### Add New LSP Server

Edit `lua/plugins/lsp/mason.lua`:

```lua
ensure_installed = {
  -- ... existing servers
  "pyright",  -- Add Python LSP
}
```

### Add New Formatter

Edit `lua/plugins/conform.lua`:

```lua
formatters_by_ft = {
  -- ... existing formatters
  python = { "black", "isort" },
}
```

### Configure LSP Server

Create `after/lsp/<server_name>.lua`:

```lua
return {
  settings = {
    -- Server-specific settings
  },
}
```

## 🔌 Plugin List

### Core

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utility functions

### UI

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - Colorscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding hints
- [snacks.nvim](https://github.com/folke/snacks.nvim) - UI utilities
- [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) - Color highlighter

### Editor

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [blink.cmp](https://github.com/saghen/blink.cmp) - Completion engine
- [comment.nvim](https://github.com/numToStr/Comment.nvim) - Comment toggling
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-close brackets
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Auto-close HTML tags

### LSP

- [mason.nvim](https://github.com/mason-org/mason.nvim) - LSP/formatter installer
- [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) - Mason LSP integration
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto-install tools
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) - Lua LSP enhancement
- [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations) - File operations

### Formatting

- [conform.nvim](https://github.com/stevearc/conform.nvim) - Format on save

### Finding

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) - UI select
- [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim) - File browser
- [telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim) - Undo history
- [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim) - Live grep with args

### File Management

- [oil.nvim](https://github.com/stevearc/oil.nvim) - File explorer as buffer
- [harpoon](https://github.com/ThePrimeagen/harpoon) - Quick file navigation

### Git

- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - LazyGit integration
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Git diff viewer
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations

### Testing

- [neotest](https://github.com/nvim-neotest/neotest) - Testing framework
- [neotest-jest](https://github.com/nvim-neotest/neotest-jest) - Jest adapter

### Utilities

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Tmux integration
- [vim-sleuth](https://github.com/tpope/vim-sleuth) - Auto-detect indentation
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git commands
- [vim-rhubarb](https://github.com/tpope/vim-rhubarb) - GitHub integration

## 🐛 Troubleshooting

### Plugins Not Loading

```bash
# Clear plugin cache
rm -rf ~/.local/share/nvim/lazy
nvim
```

### LSP Not Working

```bash
# Check LSP status
:LspInfo

# Restart LSP
:LspRestart

# Check Mason installations
:Mason
```

### Treesitter Issues

```bash
# Update all parsers
:TSUpdate

# Check parser status
:TSInstallInfo
```

### Formatter Not Working

```bash
# Check conform status
:ConformInfo

# Manually format
:lua require("conform").format()
```

## 📝 Notes

- **Format on save** is enabled for all files
- **Diagnostic virtual text** is enabled
- **Inlay hints** are configured but disabled by default (toggle with `<leader>uh`)
- **Fold level** starts at 99 (all folds open)
- **Auto-save** on `<C-s>`
- **Clipboard** syncs with system clipboard

## 🤝 Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements!

## 📄 License

MIT License - feel free to use this configuration for your own setup.

## 🙏 Credits

This configuration is built upon the excellent work of the Neovim community and various plugin authors. Special thanks to:

- [folke](https://github.com/folke) for lazy.nvim and many other plugins
- [ThePrimeagen](https://github.com/ThePrimeagen) for Harpoon
- [nvim-treesitter](https://github.com/nvim-treesitter) team
- [neovim](https://github.com/neovim/neovim) core team

---

⭐ If you found this configuration helpful, consider giving it a star!
