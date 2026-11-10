return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "vtsls", "vue_ls", "eslint", "html", "cssls", "tailwindcss" },
  },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          "stylua", -- Lua formatter
          "prettierd", -- Faster prettier
          "prettier", -- Fallback formatter
          "eslint_d", -- Faster ESLint
          "gdtoolkit", -- gdformat + gdlint for GDScript
          "tree-sitter-cli", -- required by nvim-treesitter `main` to build parsers
        },
      },
    },
    "neovim/nvim-lspconfig",
  },
}
