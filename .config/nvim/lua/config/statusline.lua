-- ** Git Status Function **
_G.git_info = function()            -- Make the function globally accessible
  local git = vim.fn.FugitiveHead() -- Get the current Git branch name
  if git ~= '' then
    return '  ' .. git .. '  '      -- Return the branch name with spaces around it
  else
    return ''
  end
end

-- ** Statusline Configuration **
vim.o.statusline = ''                                        -- Clear the statusline
vim.o.statusline = vim.o.statusline .. '%F '                 -- File name
vim.o.statusline = vim.o.statusline .. '%='                  -- Right align
vim.o.statusline = vim.o.statusline .. '%#Keyword#'          -- Highlight color
vim.o.statusline = vim.o.statusline .. '%{v:lua.git_info()}' -- Call the globally accessible git_info function
vim.o.statusline = vim.o.statusline .. '%#Keyword#'          -- Highlight color
vim.o.statusline = vim.o.statusline .. ' %l:%c '             -- Line and column info
vim.o.statusline = vim.o.statusline .. '[%n]'                -- Buffer number

-- ** Git Scroll Function **
local function git_scroll(direction)
  local save_pos = vim.fn.getpos('.') -- Save the current cursor position
  if direction == 'n' then
    vim.cmd('cnext')                  -- Go to the next item in the quickfix list
  elseif direction == 'p' then
    vim.cmd('cprevious')              -- Go to the previous item in the quickfix list
  end
  vim.fn.setpos('.', save_pos)        -- Restore the cursor position
end

-- ** Keyboard Mappings **
vim.keymap.set('n', '<Leader>n', function() git_scroll('n') end, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>p', function() git_scroll('p') end, { noremap = true, silent = true })
