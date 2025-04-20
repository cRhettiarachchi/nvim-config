return {
  'AckslD/nvim-neoclip.lua',
  dependencies = {
    -- you'll need at least one of these
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup {
      history = 100,
      on_select = {
        -- Set this to true to ensure the selected entry is set as the current register
        set_reg = true,
        -- Move entry to front of the list for easy access next time
        move_to_front = true,
        -- Close telescope after selection
        close_telescope = true,
      },
      keys = {
        telescope = {
          i = {
            select = '<cr>',
            paste = '<c-p>',
            paste_behind = '<c-i>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-e>', -- edit an entry
            custom = {},
          },
          n = {
            select = '<cr>',
            paste = 'p',
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = 'P',
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {},
          },
        },
      },
    }

    -- Add this mapping for <leader>ch
    vim.keymap.set('n', '<leader>ch', function()
      require('telescope').extensions.neoclip.neoclip()
    end, { desc = 'Open clipboard history' })
  end,
}
