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

-- Switch tabs with shift + alt + hl
map('n', '<S-A-l>', ':tabnext<CR>', opts)
map('n', '<S-A-h>', ':tabprevious<CR>', opts)
map('t', '<S-A-l>', '<C-\\><C-N>:tabnext<CR>', opts)
map('t', '<S-A-h>', '<C-\\><C-N>:tabprevious<CR>', opts)

-- Rename tab
vim.keymap.set('n', '<leader>tr', function()
  local name = vim.fn.input('Tab name: ')
  if name ~= '' then
    vim.t.tab_name = name
    vim.cmd('redrawtabline')
  end
end, opts)

-- Handle LSP Diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

local function copy_diagnostic()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics == 0 then
    print("No diagnostic message at the current line.")
    return
  end
  vim.fn.setreg('+', diagnostics[1].message)
  print("Copied to clipboard: " .. diagnostics[1].message)
end

vim.keymap.set('n', '<leader>y', copy_diagnostic, opts)
