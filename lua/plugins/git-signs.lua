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
      current_line_blame = true, -- ← inline blame like `git blame`
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = 'eol',
      },
      signcolumn = true, -- show signs in the gutter
    }
  end,
}
