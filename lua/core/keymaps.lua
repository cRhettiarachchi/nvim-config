vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Map vertical split to <leader>v
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- Map horizontal split to <leader>h
vim.keymap.set("n", "<leader>h", "<cmd>split<CR>", { desc = "Horizontal split" })
