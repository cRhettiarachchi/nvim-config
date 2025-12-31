-- Display relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true -- Also show the absolute line number on the current line

-- Copy yanked data to system clipboard
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
