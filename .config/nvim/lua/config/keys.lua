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

-- Handle LSP Diagnostics
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>y', ':lua CopyDiagnosticMessage()<CR>', opts)

function CopyDiagnosticMessage()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics == 0 then
    print("No diagnostic message at the current line.")
    return
  end

  local message = diagnostics[1].message
  vim.fn.setreg('+', message) -- Copy to system clipboard
  print("Copied to clipboard: " .. message)
end
