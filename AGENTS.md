# Agent Guidelines for Neovim Configuration

## Build/Lint/Test Commands
- **Format code**: `stylua .` or `stylua <file>`
- **Check format**: `stylua --check .`
- **Test config**: Open Neovim with `nvim` and check for errors
- **Test single plugin**: `:Lazy load <plugin-name>` or edit the plugin file in `lua/plugins/`

## Code Style Guidelines

### Formatting (via .stylua.toml)
- **Indentation**: 2 spaces (not tabs)
- **Line width**: 160 characters max
- **Quotes**: Single quotes preferred (`'string'` not `"string"`)
- **Function calls**: No parentheses for single string/table args: `require 'module'` not `require('module')`

### Structure & Organization
- **Plugin files**: Return a table with plugin spec: `return { 'author/plugin', opts = {} }`
- **Module loading**: Use `require` without parentheses for string literals
- **Comments**: Inline comments for clarification, block comments for sections
- **File organization**: Group related settings, separate with blank lines

### Naming & Conventions
- **Variables**: snake_case (`local my_var`)
- **Functions**: snake_case (`local function do_thing()`)
- **Constants**: UPPER_CASE for true constants, otherwise snake_case
- **Options**: Use `vim.o.option` for global, `vim.wo` for window, `vim.bo` for buffer

### Error Handling
- **Use pcall**: For optional dependencies: `local ok, module = pcall(require, 'module')`
- **Guard clauses**: Check conditions early and return/skip if not met
- **Deprecated APIs**: Use modern APIs (e.g., `vim.bo[bufnr].modified` not `nvim_buf_get_option`)
