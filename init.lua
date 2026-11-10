-- nvm only sets PATH in interactive shells; Node-based LSP servers
-- (tailwindcss, vtsls, ...) need node even when nvim isn't launched from one
if vim.fn.executable("node") == 0 then
  local bins = vim.fn.glob(vim.env.HOME .. "/.nvm/versions/node/*/bin", true, true)
  table.sort(bins, function(a, b)
    local va = vim.version.parse(a:match("node/v?([%d%.]+)/bin") or "0")
    local vb = vim.version.parse(b:match("node/v?([%d%.]+)/bin") or "0")
    return va and vb and va < vb or a < b
  end)
  if #bins > 0 then
    vim.env.PATH = bins[#bins] .. ":" .. vim.env.PATH
  end
end

require "config.lazy"
require "lsp"
require "core.keymaps"
require "core.options"
require "core.godot"

require("bufferline").setup{}
