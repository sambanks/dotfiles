-- ** Keymaps **

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Navigate with alt + hjkl

map('t', '<A-h>', '<C-\\><C-N><C-w>h', opts)
map('t', '<A-j>', '<C-\\><C-N><C-w>j', opts)
map('t', '<A-k>', '<C-\\><C-N><C-w>k', opts)
map('t', '<A-l>', '<C-\\><C-N><C-w>l', opts)
map('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
map('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
map('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
map('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)
map('n', '<A-h>', '<C-w>h', opts)
map('n', '<A-j>', '<C-w>j', opts)
map('n', '<A-k>', '<C-w>k', opts)
map('n', '<A-l>', '<C-w>l', opts)
