local opts = { noremap = true, silent = true }

local function keymap(mode, lhs, rhs, extra)
  return vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, extra or {}))
end

keymap({ "n", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "x", '"_x', { desc = "Delete char without yank" })
keymap("v", "p", '"_dP', { desc = "Paste over selection, keep yank" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

keymap("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })

keymap("n", "<leader>tr", "<cmd>LspRestart vtsls<CR>", { desc = "Restart vtsls" })
keymap("n", "<leader>oc", ":!google-chrome %:p &<CR><CR>", { desc = "Open file in Chrome" })

keymap({ "n", "v" }, "<leader>me", "<cmd>BookmarksMark<cr>", { desc = "Mark line in BookmarkList" })
keymap({ "n", "v" }, "<leader>mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark" })
keymap({ "n", "v" }, "<leader>ma", "<cmd>BookmarksCommands<cr>", { desc = "Bookmark commands" })
keymap("n", "<leader>mn", "<cmd>BookmarksNewList<cr>", { desc = "New bookmark list" })
keymap("n", "<leader>mt", "<cmd>BookmarksTree<cr>", { desc = "Bookmarks tree" })
keymap("n", "<leader>m]", "<cmd>BookmarksGotoNextInList<cr>", { desc = "Next in bookmark list" })
keymap("n", "<leader>m[", "<cmd>BookmarksGotoPrevInList<cr>", { desc = "Previous in bookmark list" })
keymap(
  { "n", "v" },
  "md",
  function() require("bookmarks.commands").delete_mark_of_current_file() end,
  { desc = "Delete bookmark in file" }
)

local ok, refactoring = pcall(require, "refactoring")
if ok then
  local refactor_keys = {
    { "re", "Extract Function" },
    { "rf", "Extract Function To File" },
    { "rv", "Extract Variable" },
    { "rI", "Inline Function" },
    { "ri", "Inline Variable" },
    { "rbb", "Extract Block" },
    { "rbf", "Extract Block To File" },
  }
  for _, pair in ipairs(refactor_keys) do
    local lhs, name = pair[1], pair[2]
    keymap(
      { "n", "x" },
      "<leader>" .. lhs,
      function() return refactoring.refactor(name) end,
      { expr = true, desc = "Refactor: " .. name }
    )
  end
end

keymap("v", "<leader>ol", function()
  local start_line = vim.fn.line "v"
  local end_line = vim.fn.line "."
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local result = vim.fn.expand "%:p" .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result)
end, { desc = "Copy filepath:lines for OpenCode" })

keymap("n", "<leader>cp", function()
  local path = vim.fn.expand "%:."
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

keymap("n", "<leader>al", function()
  local ref = "@" .. vim.fn.expand "%:." .. "#L" .. vim.fn.line "."
  vim.fn.setreg("+", ref)
  vim.notify("Copied: " .. ref)
end, { desc = "Copy @file#L ref for agent" })

keymap("v", "<leader>al", function()
  local s = vim.fn.line "v"
  local e = vim.fn.line "."
  if s > e then s, e = e, s end
  local ref = "@" .. vim.fn.expand "%:." .. "#L" .. s .. "-" .. e
  vim.fn.setreg("+", ref)
  vim.notify("Copied: " .. ref)
end, { desc = "Copy @file#L range ref for agent" })

-- TABS
keymap("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap("n", "[t", "<cmd>tabprev<CR>", { desc = "Prev tab" })

-- BUFFERLINE
---- In your keymaps file or init.lua
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
