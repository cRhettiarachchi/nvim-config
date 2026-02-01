local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Map vertical split to <leader>v
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- Map horizontal split to <leader>h
vim.keymap.set("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<leader>me", "<C-w>=", { desc = "Horizontal split" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

vim.keymap.set("n", "<leader>tr", "<cmd>LspRestart vtsls<CR>", { desc = "Restart vtsls" })

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

vim.keymap.set("n", "<leader>oc", ":!google-chrome %:p &<CR><CR>")
