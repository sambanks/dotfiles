" ** Globals **
set nocompatible
filetype plugin indent on
syntax on
set autoread
set nobackup
set nowritebackup
set noswapfile
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set ignorecase smartcase
set smartcase
set relativenumber
set foldmethod=indent
set foldlevel=99
set laststatus=2
set noshowmode
set noequalalways
set termguicolors
set autochdir

" ** Vim Plug **
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'Shougo/vimproc.vim', { 'for': 'typescript' }
Plug 'maralla/completor-typescript', { 'for': 'typescript' }
Plug 'maralla/completor.vim', { 'for': 'typescript' }
Plug 'prettier/vim-prettier'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'tmhedberg/SimpylFold'
Plug 'w0rp/ale'
Plug 'arcticicestudio/nord-vim'
Plug 'xolox/vim-lua-ftplugin'
Plug 'xolox/vim-misc'
Plug 'jxnblk/vim-mdx-js'
call plug#end()

" ** Prettier **
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yml,*.yaml,*.html PrettierAsync
let g:prettier#quickfix_enabled = 0

" ** Javascript **
augroup filetype_js
    au!
    au FileType javascript setlocal ts=2 sw=2
augroup END

" Check for ES6 Unused Imports"
nnoremap <leader>ji :w<CR>:call clearmatches()<CR>:let cmd = system('unused -v true ' . expand('%'))<CR>:exec cmd<CR>
" Check jsx in js files "
let g:jsx_ext_required = 0

" ** Typescript **
let g:tsuquyomi_disable_quickfix = 1
augroup filetype_typescript
    au!
    au BufRead,BufNewFile *.ts set filetype=typescript
    au FileType typescript setlocal ts=2 sw=2
augroup END
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

" ** PYTHON **
"Run Flake8 Python Linter"
augroup filetype_python
    au!
    au FileType python set omnifunc=pythoncomplete#Complete
augroup END
let g:flake8_show_in_gutter=1

" ** RUBY (Puppet & Vagrant) **
augroup filetype_ruby
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
    au Filetype ruby setlocal ts=2 sw=2 expandtab
augroup END

" ** YAML **
" Detect yaml
augroup filetype_eyaml
    au!
    au BufRead,BufNewFile *.eyaml set filetype=yaml
    au BufRead,BufNewFile *.yaml set filetype=yaml
    au BufRead,BufNewFile *.yml set filetype=yaml
    au BufRead,BufNewFile *.yml.j2 set filetype=yaml
    au FileType yaml setlocal ts=2 sw=2 expandtab
augroup END

" ** JSON **
augroup filetype_json
    au!
    au FileType json setlocal ts=2 sw=2
augroup END

" ** Markdown **
augroup filetype_md
    au!
    au BufNewFile,BufReadPost *.md set filetype=markdown
    au BufNewFile,BufReadPost *.mdx set filetype=markdown
augroup END

" ** Statusline **
" Git info
function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return '  '.git.'  '
  else
    return ''
endfunction

" Layout
set statusline=                                 " Clear the statusline for when vimrc is reloaded
set statusline+=\ %f\                           " File name
set statusline+=%=                              " Right align
set statusline+=%#Keyword#                      " Highlight colour
set statusline+=%{GitInfo()}                    " Git info
set statusline+=%#Keyword#                      " Highlight colour
set statusline+=\ \ %l:%c                       " Line and column
set statusline+=\ [%n]\                         " Buffer number

" Cycle through git history without jumping
function GitScroll(direction)
    let l:save_pos = getpos('.')
    if a:direction == 'n'
        :cnext
    elseif a:direction == 'p'
        :cprevious
    endif
    call setpos(".", save_pos)
endfunction

" ** Keyboard Mappings **
" Toggle Tagbar "
map <Leader>t :TagbarToggle<CR>
" Cycle through git history without jumping
map <Leader>n :call GitScroll('n')<CR>
map <Leader>p :call GitScroll('p')<CR>

" ** General **
" Remove trailing whitespace "
autocmd BufWritePre * %s/\s\+$//e
" Space before comments
let NERDSpaceDelims=1
" Pretty "
colorscheme nord
" Rainbow Brackets "
let g:rainbow_active = 1

" Ale "
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
