-- ** Terminal Settings **

-- Hide line numbers in terminal buffers when entering Insert mode

vim.api.nvim_create_autocmd({"TermEnter", "InsertEnter"}, {
    pattern = "term://*",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})

-- Show line numbers again when leaving Insert mode (only for terminal buffers)
vim.api.nvim_create_autocmd({"TermLeave", "InsertLeave"}, {
    pattern = "term://*",
    callback = function()
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
    end
})

-- Start in insert mode
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "term://*",
    callback = function()
        vim.cmd('startinsert')
    end
})
