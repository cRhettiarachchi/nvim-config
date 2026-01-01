return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  -- init = function() require("nvim-treesitter").setup {} end,

  init = function()
    require("nvim-treesitter").setup {
      -- Ensure that parsers for your desired languages are installed
      ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python" },

      -- Enable syntax highlighting
      highlight = {
        enable = true,
        -- Disable highlighting for specific filetypes (optional)
        disable = { "rb" },
      },

      -- Enable indentation (optional)
      indent = { enable = true },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "<filetype>" },
      callback = function() vim.treesitter.start() end,
    })
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
  end,
}
