-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = 'eol',
      },
      signcolumn = true,
    }

    local gs = require 'gitsigns'

    -- Git keymaps
    -- Next and previous hunk navigation
    vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>')

    -- Preview hunk automatically when navigating
    vim.keymap.set('n', '<leader>gn', function()
      require('gitsigns').next_hunk()
      require('gitsigns').preview_hunk()
    end, { noremap = true })

    vim.keymap.set('n', '<leader>gp', function()
      require('gitsigns').preview_hunk()
    end, { noremap = true })

    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage Git hunk' })
    vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage Git hunk' })
    vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle current line blame' })
  end,
}
