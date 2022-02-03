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
set foldmethod=indent
set foldlevel=99
set laststatus=2
set noshowmode
set noequalalways
set termguicolors
set autochdir
set noeb vb t_vb=
set encoding=utf8
" set colorcolumn=88
au GUIEnter * set vb t_vb=

" ** Vim Plug **
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tmhedberg/SimpylFold'
Plug 'arcticicestudio/nord-vim'
Plug 'pprovost/vim-ps1'
Plug 'ryanoasis/vim-devicons'
Plug 'pearofducks/ansible-vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" * COC **
let g:coc_global_extensions = [ 'coc-json', 'coc-git', 'coc-prettier', 'coc-pyright', '@yaegassy/coc-ansible',
  \ 'coc-clangd', 'coc-css', 'coc-eslint', 'coc-explorer', 'coc-html', 'coc-html-css-support',
  \ 'coc-markdownlint', 'coc-markdown-preview-enhanced', 'coc-omnisharp', 'coc-powershell',
  \ 'coc-pydocstring', 'coc-sh', 'coc-tsserver', 'coc-xml', 'coc-yaml', 'coc-snippets']

" * Ansible **
let g:coc_filetype_map = { 'yaml.ansible': 'ansible' }

" ** Python **
autocmd FileType python let b:coc_root_patterns = ['.env', '.venv']

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

" ** Markdown **
augroup filetype_md
    au!
    au BufNewFile,BufReadPost *.md set filetype=markdown
    au BufNewFile,BufReadPost *.mdx set filetype=markdown
augroup END

" ** Git status **
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
map <Leader>n :call GitScroll('n')<CR>
map <Leader>p :call GitScroll('p')<CR>
map <leader>e :CocCommand explorer<CR>

" ** General **
" Remove trailing whitespace "
autocmd BufWritePre * %s/\s\+$//e
" Space before comments
let NERDSpaceDelims=1
" Pretty "
set background=dark
colorscheme nord
