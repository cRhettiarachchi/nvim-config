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
    vim.keymap.set('n', ']g', gs.next_hunk, { desc = 'Next Git hunk' })
    vim.keymap.set('n', '[g', gs.prev_hunk, { desc = 'Previous Git hunk' })

    -- Preview hunk automatically when navigating
    vim.keymap.set('n', '<leader>gn', function()
      gs.next_hunk()
      gs.preview_hunk()
    end, { noremap = true, desc = 'Next hunk and preview' })

    vim.keymap.set('n', '<leader>gp', function()
      gs.preview_hunk()
    end, { noremap = true, desc = 'Preview hunk' })

    vim.keymap.set('n', '<leader>gh', gs.stage_hunk, { desc = 'Stage Git hunk' })
    vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage Git hunk' })
    vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle current line blame' })
  end,
}
