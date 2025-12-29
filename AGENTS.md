# Agent Guidelines for Neovim Configuration

## Build/Lint/Test Commands

- **Format code**: `stylua .` or `stylua <file>`
- **Check format**: `stylua --check .`
- **Test config**: `nvim` and check for errors (`:checkhealth` for diagnostics)
- **Test single plugin**: `:Lazy load <plugin-name>` in Neovim
- **Reload config**: `:source ~/.config/nvim/init.lua` or restart Neovim

## Project Structure

- **Entry point**: `init.lua` requires `chari.core`, `chari.lazy`, `chari.lsp`
- **Core config**: `lua/chari/core/` (options, keymaps, snippets)
- **Plugins**: `lua/chari/plugins/` (each plugin in separate file)
- **LSP config**: `lua/chari/plugins/lsp/` (lsp.lua, mason.lua)
- **Plugin manager**: Lazy.nvim auto-imports from `chari.plugins` and `chari.plugins.lsp`

## Code Style Guidelines

### Formatting (via .stylua.toml)

- **Indentation**: 2 spaces (not tabs)
- **Line width**: 160 characters max
- **Quotes**: Single quotes preferred (`'string'` not `"string"`)
- **Function calls**: No parentheses for single string/table args: `require 'module'` not `require('module')`

### Structure & Organization

- **Plugin files**: Return table with spec: `return { 'author/plugin', opts = {}, config = function() end }`
- **Module loading**: Use `require` without parentheses for string literals
- **Keymaps in plugins**: Define in plugin's `config` function, not in separate keymap file
- **Comments**: Inline `--` for clarity, block comments for sections/explanations
- **File organization**: Group related settings with blank lines between sections

### Naming & Conventions

- **Variables**: snake_case (`local my_var`, `local builtin`)
- **Functions**: snake_case (`local function do_thing()`, `function GrepByExtension()`)
- **Constants**: UPPER_CASE for true constants, otherwise snake_case
- **Vim options**: Use `vim.o.option` (global), `vim.wo` (window), `vim.bo` (buffer), `vim.opt` (with `:append`/`:remove`)

### Error Handling

- **Use pcall**: For optional deps: `pcall(require('telescope').load_extension, 'fzf')`
- **Guard clauses**: Check conditions early: `if not term or term == '' then return end`
- **vim.schedule**: Wrap async UI operations: `vim.schedule(function() print 'message' end)`
