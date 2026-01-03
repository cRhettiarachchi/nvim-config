return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "lua_ls", "ts_ls", "vue_ls", "eslint", "html", "cssls", "tailwindcss" },
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
        },
      },
    },
    "neovim/nvim-lspconfig",
  },
}

