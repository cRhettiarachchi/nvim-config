return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").setup {
      -- Ensure that parsers for your desired languages are installed
      ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "vue", "html", "css" },

      -- Enable syntax highlighting
      highlight = {
        enable = true,
        -- Disable highlighting for specific filetypes (optional)
        disable = { "rb" },
      },

      -- Enable indentation (optional)
      indent = { enable = true },

      -- Enable folding
      fold = {
        enable = true,
      },
    }

    -- Enable treesitter-based folding
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldopen = vim.o.foldopen:gsub("block,", "")
  end,
}
