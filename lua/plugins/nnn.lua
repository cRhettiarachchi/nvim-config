return {
  'luukvbaal/nnn.nvim',
  config = function()
    require('nnn').setup {
      replace_netrw = 'picker', -- replace netrw with floating picker
      windownav = {
        left = '<C-h>',
        right = '<C-l>',
        next = '<C-w>w',
        prev = '<C-w>W',
      },
      picker = {
        style = {
          border = 'rounded',
        },
        session = 'shared',
      },
      explorer = {
        width = 30,
        side = 'topleft',
        session = 'shared',
      },
      auto_close = false,
      auto_open = {
        setup = nil,
        tabpage = nil,
        empty = false,
        ft_ignore = { 'gitcommit' },
      },
    }

    -- Keybindings
    -- Explorer mode on <leader>de (Directory Explorer)
    -- vim.keymap.set('n', '<leader>de', '<cmd>NnnExplorer %:p:h<CR>', { noremap = true, silent = true })
    -- vim.keymap.set('t', '<leader>de', '<cmd>NnnExplorer<CR>', { noremap = true, silent = true })

    -- Picker mode on <leader>df (Directory Floating)
    vim.keymap.set('n', '<leader>de', '<cmd>NnnPicker<CR>', { noremap = true, silent = true })
    vim.keymap.set('t', '<leader>de', '<cmd>NnnPicker<CR>', { noremap = true, silent = true })
  end,
}
