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

    -- .tscn/.tres are filetype `gdresource`, but the parser is `godot_resource`.
    vim.treesitter.language.register("godot_resource", "gdresource")

    -- nvim-treesitter `main` installs nothing from `setup` and starts no
    -- highlighter, so do both explicitly for the Godot filetypes.
    local godot = { "gdscript", "gdshader", "godot_resource" }
    local installed = require("nvim-treesitter.config").get_installed "parsers"
    local missing = vim.tbl_filter(function(p) return not vim.tbl_contains(installed, p) end, godot)
    if #missing > 0 then require("nvim-treesitter").install(missing) end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "gdscript", "gdshader", "gdresource" },
      callback = function() pcall(vim.treesitter.start) end,
    })

    -- Enable treesitter-based folding
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldopen = vim.o.foldopen:gsub("block,", "")
  end,
}
