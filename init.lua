require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

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
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.comment',
  require 'plugins.neotest',
  require 'plugins.tabout',
  require 'plugins.eslint-nvim',
  require 'plugins.nvim-ts-autotag',
  require 'plugins.snacks',
  require 'plugins.leet-code',
  require 'plugins.neo-clip',
  require 'plugins.colortheme',
  require 'plugins.flash',
}

require('everforest').load()
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
