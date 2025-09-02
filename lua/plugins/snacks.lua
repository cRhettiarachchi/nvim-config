return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
    },
    explorer = {
      enabled = true,
    },
    indent = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,

      -- 1) Define actions once
      actions = {
        copy_path_abs = function(_, item)
          if not item then
            return
          end
          local path = item.path or item.file or item.filename
          if not path then
            return
          end
          vim.fn.setreg('+', path)
          vim.notify('Copied path: ' .. path)
        end,

        copy_path_rel = function(_, item)
          if not item then
            return
          end
          local path = item.path or item.file or item.filename
          if not path then
            return
          end
          local rel = vim.fn.fnamemodify(path, ':.')
          vim.fn.setreg('+', rel)
          vim.notify('Copied relative: ' .. rel)
        end,
      },

      -- 2) Bind keys for the picker input (both normal & insert modes)
      win = {
        input = {
          keys = {
            ['<C-y>'] = { 'copy_path_abs', mode = { 'n', 'i' } },
            ['<C-r>'] = { 'copy_path_rel', mode = { 'n', 'i' } },
          },
        },
      },
    },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- File Search
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },

    -- Grep/Search
    {
      '<leader>sg',
      function()
        Snacks.picker.grep {
          command = { 'rg', '--vimgrep', '--smart-case', '--word-regexp' },
        }
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Grep Word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>db',
      function()
        Snacks.dashboard.open()
      end,
      desc = 'Snacks Dashboard',
      mode = { 'n' },
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Grep Word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },

    -- Diagnostics
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },

    -- Zen Mode
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },

    -- Lazygit
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>j1',
      function()
        Snacks.picker.explorer()
      end,
      desc = 'Snacks explorer',
    },
    -- Scratch buffer
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    -- Command history
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    -- Search commands
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },

    -- Search existing buffers
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
  },
}
