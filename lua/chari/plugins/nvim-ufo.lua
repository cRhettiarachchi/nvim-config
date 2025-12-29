return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Still needed for Treesitter folding provider
    'neovim/nvim-lspconfig', -- Essential for LSP folding provider
    'kevinhwang91/promise-async', -- Required by nvim-ufo
  },
  event = 'BufReadPost', -- Load after buffer is read
  config = function()
    -- Enable folding by default
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'v:lua.vim.ufos.foldexpr()'

    -- UFO setup
    require('ufo').setup {
      open_fold_hl_timeout = 150,
      close_fold_hl_timeout = 150,
      fold_virt_text_handler = function(virt_text, lnum, endLnum, width, truncate)
        local new_virt_text = {}
        local suffix = (' ... %d lines'):format(endLnum - lnum)
        local suf_width = vim.fn.strdisplaywidth(suffix)
        local target_width = width - suf_width
        local cur_width = 0
        for _, chunk in ipairs(virt_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)
          if target_width > cur_width + chunk_width then
            table.insert(new_virt_text, chunk)
            cur_width = cur_width + chunk_width
          else
            chunk_text = truncate(chunk_text, target_width - cur_width)
            table.insert(new_virt_text, { chunk_text, chunk[2] })
            cur_width = cur_width + vim.fn.strdisplaywidth(chunk_text)
            break
          end
        end
        table.insert(new_virt_text, { suffix, 'MoreMsg' }) -- Add suffix with different highlight
        return new_virt_text
      end,
      providers = { 'lsp', 'treesitter', 'indent' },
    }

    -- 🕙 Defer keymaps until after plugin loads to prevent "got nil" errors
    vim.schedule(function()
      local ufo = require 'ufo'
      if ufo.openAllFolds then
        vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'UFO: Open all folds' })
      end
      if ufo.closeAllFolds then
        vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'UFO: Close all folds' })
      end
      if ufo.openFold then
        vim.keymap.set('n', 'zr', ufo.openFold, { desc = 'UFO: Open fold' })
      end
      if ufo.closeFold then
        vim.keymap.set('n', 'zm', ufo.closeFold, { desc = 'UFO: Close fold' })
      end
      -- zi / za = toggle current fold
      if ufo.toggleFold then
        vim.keymap.set('n', 'zi', ufo.toggleFold, { desc = 'UFO: Toggle fold' })
        vim.keymap.set('n', 'za', ufo.toggleFold, { desc = 'UFO: Toggle fold' })
      end
    end)

    -- Optional: LSP on_attach folding integration
    local on_attach = function(client, bufnr)
      if client.server_capabilities.foldingRangeProvider then
        vim.api.nvim_buf_set_option(bufnr, 'foldmethod', 'expr')
        vim.api.nvim_buf_set_option(bufnr, 'foldexpr', 'v:lua.vim.ufos.foldexpr()')
      end
    end
    -- Example for LSP setup
    -- require('lspconfig').tsserver.setup { on_attach = on_attach }
    -- require('lspconfig').pyright.setup { on_attach = on_attach }
  end,
}