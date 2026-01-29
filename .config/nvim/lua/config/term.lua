-- ** Terminal Settings **

-- Hide line numbers in terminal buffers

vim.api.nvim_create_autocmd({"TermOpen", "TermEnter"}, {
    pattern = "term://*",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})

-- Start in insert mode
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "term://*",
    callback = function()
        vim.cmd('startinsert')
    end
})
