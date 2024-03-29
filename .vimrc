" ** Globals **
set nocompatible
filetype plugin indent on
syntax on
set autoread
set nobackup
set nowritebackup
set noswapfile
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set ignorecase smartcase
set smartcase
set relativenumber
set foldmethod=manual
set foldlevel=99
set laststatus=2
set noshowmode
set noequalalways
set termguicolors
set autochdir
set noeb vb t_vb=
set encoding=utf8
au GUIEnter * set vb t_vb=

" ** Vim Plug **
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'github/copilot.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-plug'
Plug 'jvirtanen/vim-hcl'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'
Plug 'pprovost/vim-ps1'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

" * COC **
let g:coc_global_extensions = [
  \ '@yaegassy/coc-ansible',
  \ 'coc-clangd',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-html-css-support',
  \ 'coc-json',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-markdownlint',
  \ 'coc-omnisharp',
  \ 'coc-powershell',
  \ 'coc-prettier',
  \ 'coc-pydocstring',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-xml',
  \ 'coc-yaml',
\ ]

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" * Ansible **
let g:coc_filetype_map = { 'yaml.ansible': 'ansible' }

" * Copilot **
let g:copilot_filetypes = {'yaml': v:true}

" ** Python **
autocmd FileType python let b:coc_root_patterns = ['.env', '.venv']
let g:black_linelength = 100

" ** Javascript **
augroup filetype_js
    au!
    au FileType javascript setlocal ts=2 sw=2
augroup END
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ** JSON **
augroup filetype_json
    au!
    au FileType json setlocal ts=2 sw=2
augroup END

" ** Git status **
function! GitInfo()
  let git = FugitiveHead()
  if git != ''
    return '  '.git.'  '
  else
    return ''
endfunction

" Layout
set statusline=                " Clear the statusline for when vimrc is reloaded
set statusline+=\ %F\          " File name
set statusline+=%=             " Right align
set statusline+=%#Keyword#     " Highlight colour
set statusline+=%{GitInfo()}   " Git info
set statusline+=%#Keyword#     " Highlight colour
set statusline+=\ \ %l:%c      " Line and column
set statusline+=\ [%n]\        " Buffer number

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
map <Leader>n :call GitScroll('n')<CR>
map <Leader>p :call GitScroll('p')<CR>
map <leader>e :CocCommand explorer<CR>

" ** General **

" Remove trailing whitespace
let whitspaceIgnore = ['markdown']
autocmd BufWritePre * if index(whitspaceIgnore, &ft) < 0 | %s/\s\+$//e

" Space before comments
let NERDSpaceDelims=1

" Pretty
set background=dark
colorscheme nord
