-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local alternate_buf = vim.fn.bufnr '#' -- previous buffer

  -- Count the number of listed buffers
  local listed = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
  end, vim.api.nvim_list_bufs())

  if #listed > 1 and vim.api.nvim_buf_is_loaded(alternate_buf) then
    vim.cmd 'b#' -- go to previous buffer
    vim.cmd('bdelete ' .. current_buf) -- delete the old one
  else
    -- Create a new empty buffer and switch to it
    vim.cmd 'enew' -- create an empty buffer
    vim.cmd('bdelete ' .. current_buf)
  end
end, { desc = 'Smart buffer close', noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>cs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>nto', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>cd', ':%bd | e# | bd#<CR>', opts)

vim.keymap.set('n', '<leader>of', ':!open -R %<CR>', opts)

vim.keymap.set('n', '<leader>nr', ':set relativenumber<CR>', opts)

vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%:p:h'
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { desc = 'Copy current file directory to clipboard' })

vim.keymap.set('n', '<leader>i', function()
  vim.o.ignorecase = not vim.o.ignorecase
  vim.o.smartcase = vim.o.ignorecase -- Enable smartcase only when ignorecase is on
  print('ignorecase: ' .. tostring(vim.o.ignorecase) .. ', smartcase: ' .. tostring(vim.o.smartcase))
end, { desc = 'Toggle ignorecase + smartcase' })

-- Swap buffer with the pane to the right
vim.keymap.set('n', '<leader>ml', function()
  local cur_buf = vim.fn.bufnr '%'
  local cur_win = vim.api.nvim_get_current_win()

  vim.cmd 'wincmd l' -- go to right pane
  local right_buf = vim.fn.bufnr '%'
  local right_win = vim.api.nvim_get_current_win()

  -- Set current buffer into right window
  vim.api.nvim_set_current_buf(cur_buf)

  -- Go back and set right buffer into current window
  vim.api.nvim_set_current_win(cur_win)
  vim.api.nvim_set_current_buf(right_buf)
end, { desc = 'Swap buffer with right pane' })

-- Swap buffer with the pane to the left
vim.keymap.set('n', '<leader>mh', function()
  local cur_buf = vim.fn.bufnr '%'
  local cur_win = vim.api.nvim_get_current_win()

  vim.cmd 'wincmd h' -- go to left pane
  local left_buf = vim.fn.bufnr '%'
  local left_win = vim.api.nvim_get_current_win()

  -- Set current buffer into left window
  vim.api.nvim_set_current_buf(cur_buf)

  -- Go back and set left buffer into current window
  vim.api.nvim_set_current_win(cur_win)
  vim.api.nvim_set_current_buf(left_buf)
end, { desc = 'Swap buffer with left pane' })
