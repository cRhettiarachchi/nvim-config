return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
    { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Branch History' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = 'diff2_horizontal',
        winbar_info = true,
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true, -- Less noise during conflict resolution
        winbar_info = true, -- Show OURS/BASE/THEIRS labels
      },
    },
    file_panel = {
      listing_style = 'tree',
      win_config = {
        position = 'left',
        width = 35,
      },
    },
    file_history_panel = {
      win_config = {
        position = 'bottom',
        height = 16,
      },
    },
    keymaps = {
      view = {
        -- Conflict resolution keymaps
        ['<leader>co'] = '<Cmd>DiffviewConflictChooseOurs<CR>',
        ['<leader>ct'] = '<Cmd>DiffviewConflictChooseTheirs<CR>',
        ['<leader>cb'] = '<Cmd>DiffviewConflictChooseBase<CR>',
        ['<leader>ca'] = '<Cmd>DiffviewConflictChooseAll<CR>',
        ['<leader>cn'] = '<Cmd>DiffviewConflictNextConflict<CR>',
        ['<leader>cp'] = '<Cmd>DiffviewConflictPrevConflict<CR>',
        ['dx'] = '<Cmd>DiffviewConflictChooseNone<CR>',

        -- Navigation shortcuts
        [']x'] = '<Cmd>DiffviewConflictNextConflict<CR>',
        ['[x'] = '<Cmd>DiffviewConflictPrevConflict<CR>',
      },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        -- Disable folding in diff buffers for better visibility
        vim.opt_local.foldenable = false
      end,
    },
  },
}
