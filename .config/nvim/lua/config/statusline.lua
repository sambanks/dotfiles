-- ** Git Status Function **
_G.git_info = function()
  if vim.bo.buftype == 'terminal' then
    return ''
  end
  local head = vim.fn.FugitiveHead()
  if head ~= '' then
    return '  ' .. head .. '  '
  end
  return ''
end

-- ** Custom Path Formatter for Statusline **
_G.statusline_path = function()
  local buftype = vim.bo.buftype
  local bufname = vim.api.nvim_buf_get_name(0)

  -- Handle terminal buffers
  if buftype == 'terminal' then
    local term_title = vim.fn.expand('%:t')
    return ' TERM: ' .. term_title
  end

  -- Handle empty buffers
  if bufname == '' then
    return '[No Name]'
  end

  -- For regular files, show path relative to cwd if possible
  local cwd = vim.fn.getcwd()
  local relative_path = vim.fn.fnamemodify(bufname, ':~:.')

  -- If the path is too long, show just parent dir + filename
  if #relative_path > 60 then
    local tail = vim.fn.fnamemodify(bufname, ':t')
    local parent = vim.fn.fnamemodify(bufname, ':h:t')
    return parent .. '/' .. tail
  end

  return relative_path
end

-- ** Custom Highlight Groups **
-- Derive background from StatusLine so it works for both focused and unfocused windows
local function setup_statusline_highlights()
  local sl = vim.api.nvim_get_hl(0, { name = 'StatusLine' })
  local bg = sl.bg
  vim.api.nvim_set_hl(0, 'StatusLineGit', { fg = '#a9b665', bg = bg, bold = true })
end

vim.api.nvim_create_autocmd('ColorScheme', { callback = setup_statusline_highlights })
setup_statusline_highlights()

-- ** Statusline Configuration **
vim.o.statusline = ' %{v:lua.statusline_path()} %=%#StatusLineGit#%{v:lua.git_info()}%* %l:%c [%n]'

-- ** Custom Tabline **
_G.custom_tabline = function()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, '&buftype')

    -- Tab highlighting
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- Tab number
    s = s .. ' ' .. i .. ' '

    -- Format the filename
    local display_name
    if buftype == 'terminal' then
      -- For terminal buffers, show shell type
      display_name = vim.fn.fnamemodify(bufname, ':t')
      if display_name:match('^term://') then
        display_name = 'zsh'
      end
    elseif bufname == '' then
      display_name = '[No Name]'
    else
      -- Get absolute path first, then format consistently
      local fullpath = vim.fn.fnamemodify(bufname, ':p')
      local filename = vim.fn.fnamemodify(fullpath, ':t')
      local parent = vim.fn.fnamemodify(fullpath, ':h:t')
      if parent ~= '' and parent ~= '.' and parent ~= '/' then
        display_name = parent .. '/' .. filename
      else
        display_name = filename
      end
    end

    s = s .. display_name .. ' '
  end

  s = s .. '%#TabLineFill#'
  return s
end

vim.o.tabline = '%!v:lua.custom_tabline()'

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
