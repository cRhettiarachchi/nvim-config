# AGENTS.md - Neovim Configuration Guide

This document provides guidelines for AI coding agents working on this Neovim configuration.

## Repository Overview

This is a personal Neovim configuration using **Lazy.nvim** as the plugin manager. The config follows a modular structure with plugins organized by functionality.

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   └── lazy.lua           # Lazy.nvim bootstrap and setup
│   ├── core/
│   │   ├── keymaps.lua        # Global keymaps
│   │   └── options.lua        # Vim options and autocommands
│   ├── plugins/
│   │   ├── init.lua           # UI plugins (colorscheme, which-key)
│   │   ├── lsp/               # LSP-related plugins
│   │   │   ├── lsp.lua        # LSP file operations, lazydev
│   │   │   └── mason.lua      # Mason LSP installer config
│   │   ├── blink-cmp.lua      # Completion engine
│   │   ├── comment.lua        # Comment toggling
│   │   ├── conform.lua        # Code formatting
│   │   ├── lazygit.lua        # Git integration
│   │   ├── oil.nvim           # File explorer
│   │   ├── snacks.nvim        # Multi-purpose plugin suite
│   │   └── telescope.lua      # Fuzzy finder
│   └── lsp.lua                # LSP keymaps and configuration
├── lazy-lock.json             # Plugin version lock file
└── stylua.toml                # Lua formatter configuration
```

## Build/Lint/Test Commands

### Formatting

```bash
# Format all Lua files using stylua
stylua lua/ init.lua

# Format specific file
stylua lua/plugins/telescope.lua

# Check formatting without modifying files
stylua --check lua/
```

### Linting

```bash
# No dedicated linter configured yet
# LSP (lua_ls) provides diagnostics when Neovim is running
```

### Testing

```bash
# No automated tests currently configured
# Manual testing: Open Neovim and check for errors
nvim

# Check plugin status
nvim -c "Lazy" -c "q"

# Check LSP status
nvim -c "LspInfo" -c "q"

# Verify configuration loads without errors
nvim --headless -c "qa"
```

### Plugin Management

```bash
# Sync plugins (install/update/clean)
nvim -c "Lazy sync" -c "q"

# Update plugins
nvim -c "Lazy update" -c "q"

# Clean unused plugins
nvim -c "Lazy clean" -c "q"
```

## Code Style Guidelines

### Lua Formatting (stylua.toml)

- **Column width**: 120 characters
- **Line endings**: Unix (LF)
- **Indentation**: 2 spaces (no tabs)
- **Quote style**: Auto-prefer double quotes
- **Call parentheses**: None (omit when possible)
- **Collapse simple statements**: Always

### File Organization

#### Plugin Files

Each plugin file should return a table (or array of tables) with plugin specifications:

```lua
return {
  "author/plugin-name",
  dependencies = { "dependency/plugin" },
  opts = {
    -- plugin options
  },
  config = function()
    -- custom configuration
  end,
}
```

#### Multi-plugin Files

When a file contains multiple related plugins:

```lua
return {
  {
    "plugin/one",
    opts = {},
  },
  {
    "plugin/two",
    opts = {},
  },
}
```

### Import Conventions

#### Lazy.nvim Imports

In `lua/config/lazy.lua`, use the `import` spec to load plugin directories:

```lua
require("lazy").setup({
  spec = {
    { import = "plugins" },        -- Loads lua/plugins/*.lua
    { import = "plugins.lsp" },    -- Loads lua/plugins/lsp/*.lua
  },
})
```

**CRITICAL**: When using `{ import = "plugins.lsp" }`:

- Lazy.nvim will load ALL `.lua` files directly in `lua/plugins/lsp/`
- Files must have `.lua` extension (NOT `.lsp` or other extensions)
- Subdirectories are NOT recursively scanned

#### Module Requires

Use double quotes for require statements:

```lua
local telescope = require "telescope"  -- Preferred (no parentheses)
local builtin = require("telescope.builtin")  -- Also acceptable
```

### Naming Conventions

- **Files**: Use lowercase with hyphens: `telescope.lua`, `blink-cmp.lua`
- **Variables**: Use snake_case: `local builtin`, `local opts`
- **Functions**: Use snake_case: `function setup_keymaps()`
- **Constants**: Use UPPER_SNAKE_CASE: `local MAX_WIDTH = 120`

### Keymap Conventions

#### Standard Format

```lua
vim.keymap.set("mode", "lhs", "rhs", { desc = "Description" })
```

#### Lazy-loading with Lazy.nvim

For plugins that should lazy-load on keypress:

```lua
keys = {
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
}
```

#### Function-based Keymaps

When calling Lua functions:

```lua
vim.keymap.set("n", "<leader>sf", function()
  require("telescope.builtin").find_files()
end, { desc = "Find Files" })
```

### Plugin Dependencies

#### Required Dependencies

Always declare dependencies explicitly:

```lua
return {
  "plugin/name",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- Many plugins require this
  },
}
```

#### Common Dependencies

- `plenary.nvim`: Required by Telescope, many file operation plugins
- `nvim-web-devicons` or `mini.icons`: Icon support
- `nvim-treesitter`: Syntax highlighting for many plugins

**IMPORTANT**: System binaries (like `ripgrep`, `fd`, `git`) cannot be installed via Lazy.nvim dependencies. They must be installed via system package managers.

### Error Handling

- Use `pcall` for operations that might fail:

```lua
local ok, module = pcall(require, "optional-module")
if not ok then
  vim.notify("Module not found", vim.log.levels.WARN)
  return
end
```

### Extension Loading (Telescope)

**CRITICAL RULE**: Extension names use underscores, not hyphens:

```lua
-- Plugin name (in dependencies)
"nvim-telescope/telescope-live-grep-args.nvim"

-- Extension loading (underscores!)
telescope.load_extension("live_grep_args")

-- Extension usage (underscores!)
require("telescope").extensions.live_grep_args.live_grep_args()
```

## Common Patterns

### Autocommands

```lua
vim.api.nvim_create_autocmd("Event", {
  pattern = "*",
  callback = function(args)
    -- action
  end,
})
```

### LSP Configuration

LSP keymaps are configured in `lua/lsp.lua` using the `LspAttach` autocmd pattern.

## Git Commit Style

Based on recent commits:

- Use present tense: "Add feature" not "Added feature"
- Be concise: "Snacks and telescope" or "Updated config"
- Capitalize first letter
- No period at the end

## Notes for Agents

1. **Always use `.lua` extension** for plugin files, never `.lsp` or other extensions
2. **Telescope extensions**: Use underscores in `load_extension()`, not hyphens
3. **Format on save**: Conform.nvim auto-formats on `BufWritePre`
4. **Leader key**: Space (`<leader> = " "`)
5. **Local leader**: Backslash (`<localleader> = "\\"`)
6. **Plugin manager**: Lazy.nvim (never use Packer, vim-plug, etc.)
7. **Completion**: blink.cmp (not nvim-cmp)
8. **File explorer**: oil.nvim and snacks.explorer
9. **Colorscheme**: kanagawa-dragon

## Troubleshooting

- If plugins don't load: Check file extensions are `.lua`
- If extensions fail: Verify extension names use underscores
- If formatting fails: Ensure stylua is installed (`brew install stylua`)
- If LSP doesn't work: Run `:LspInfo` and `:Mason` to check server status
