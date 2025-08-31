require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Optional startup profiling (uncomment to enable profiling)
-- vim.loader.enable()  -- Use bytecode cache for faster startup
-- vim.g.profile_startup = true
-- if vim.g.profile_startup then
--   local startuptime = vim.fn.reltime()
--   vim.api.nvim_create_autocmd("UIEnter", {
--     once = true,
--     callback = function()
--       local elapsed = vim.fn.reltimestr(vim.fn.reltime(startuptime))
--       print(string.format("Neovim loaded in %ss", elapsed))
--     end,
--   })
-- end

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_user_command('FixIndent', function()
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
  vim.cmd 'normal gg=G'
end, {})

vim.keymap.set('n', '<leader>ra', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.fn.buflisted(bufnr) == 1 then
      local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
      if not modified then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd 'checktime'
        end)
      end
    end
  end

  local ok, neotree = pcall(require, 'neo-tree.sources.manager')
  if ok then
    neotree.refresh 'filesystem'
  end
end, { desc = 'Reload All Buffers if Not Modified' })

-- Set up plugins
require('lazy').setup {
  -- Core UI components
  require 'plugins.colortheme',
  -- require 'plugins.cool-night',
  require 'plugins.alpha',
  require 'plugins.lualine',
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.indent-blankline',
  require 'plugins.nvim-ufo',

  -- Core functionality
  require 'plugins.treesitter',
  require 'plugins.telescope',

  -- Development tools - JS/TS focused
  require 'plugins.lsp', -- Language servers with web-first priority
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.eslint-nvim',
  require 'plugins.nvim-ts-autotag',

  -- Git integration
  require 'plugins.gitsigns',

  -- Editor enhancements
  require 'plugins.misc',
  require 'plugins.comment',
  require 'plugins.tabout',
  require 'plugins.flash',
  require 'plugins.neo-clip',

  -- Testing tools
  require 'plugins.neotest',
  require 'plugins.copilot-chat',

  -- Extras
  require 'plugins.snacks',
  require 'plugins.leet-code',
  require 'plugins.todo-comments',
  require 'plugins.inc-rename',
  require 'plugins.nnn',
}

-- Set colorscheme
vim.g.edge_style = 'aura' -- or any style you want
vim.cmd.colorscheme 'edge'

-- Define custom highlight colors for normal and inactive windows
vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#232530' }) -- active
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2e3240' }) -- lighter than #262a36
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#ff5f5f', underline = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff5f5f' })
