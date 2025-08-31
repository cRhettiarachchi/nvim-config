-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- Tmux & split window navigation
    'christoomey/vim-tmux-navigator',
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
  },
  {
    'github/copilot.vim',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Instead of `config = true, opts = {}`, we provide a specific `config` function
    config = function()
      require('nvim-autopairs').setup {
        -- Enable Tree-sitter checking. This is VITAL for JSX.
        check_ts = true,
        ts_config = {
          -- Define which Tree-sitter nodes Autopairs should check for
          -- These are the key ones for JSX/TSX
          javascript = { 'string', 'comment', 'jsx_element', 'jsx_fragment' },
          typescript = { 'string', 'comment', 'jsx_element', 'jsx_fragment' },
          -- If you're using .jsx files, their filetype might be 'javascriptreact'
          javascriptreact = { 'string', 'comment', 'jsx_element', 'jsx_fragment' },
          -- If you're using .tsx files, their filetype might be 'typescriptreact'
          typescriptreact = { 'string', 'comment', 'jsx_element', 'jsx_fragment' },
          -- A fallback for other languages
          ['*'] = { 'string', 'comment' },
        },
        -- You can disable autopairs for specific filetypes if needed
        disable_filetype = { 'TelescopePrompt', 'vim' },
      }

      -- This part integrates nvim-autopairs with nvim-cmp (if you're using it)
      -- It ensures tags are closed even when you select a completion item.
      -- If you don't use nvim-cmp, you can omit these lines, but it's highly recommended
      -- for a smoother experience.
      if pcall(require, 'cmp') and pcall(require, 'nvim-autopairs.completion.cmp') then
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
}
