local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "LSP References"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "LSP Declaration"
    keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "LSP Definition"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "LSP Implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "LSP Type Definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function() vim.diagnostic.jump { count = -1, float = true } end, opts) -- jump to previous diagnostic in buffer
    --
    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function() vim.diagnostic.jump { count = 1, float = true } end, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

-- Configure typos-lsp (Neovim 0.11+ API)
vim.lsp.config("typos_lsp", {
  cmd = { "typos-lsp" },
  cmd_env = { RUST_LOG = "error" },
  filetypes = { "markdown", "text", "lua", "javascript", "typescript", "vue", "html", "css", "python", "rust", "go" },
  root_markers = { ".git", "package.json", "Cargo.toml" },
  settings = {
    diagnosticSeverity = "Hint",
  },
})

-- Enable typos-lsp for configured filetypes
vim.lsp.enable "typos_lsp"

vim.diagnostic.config {
  virtual_text = true, -- Enable inline diagnostic text
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
  underline = true,
}

-- Make diagnostic underlines more visible
-- Using both undercurl and underline for better terminal compatibility
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, underline = true, sp = "#E82424" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, underline = true, sp = "#FF9E3B" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, underline = true, sp = "#658594" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, underline = true, sp = "#7FB4CA" }) -- Bright blue for typos
