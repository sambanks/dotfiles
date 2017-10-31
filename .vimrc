set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'isRuslan/vim-es6'
Plugin 'vim-syntastic/syntastic'
Plugin 'mxw/vim-jsx'
Plugin 'suan/vim-instant-markdown'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'junegunn/fzf'
Plugin 'tell-k/vim-autopep8'
Plugin 'sbdchd/neoformat'
Plugin 'PProvost/vim-ps1'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'nvie/vim-flake8'

call vundle#end()            " required

filetype plugin indent on
syntax on
set autoread
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set ignorecase
set smartcase
set bg=dark

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

autocmd FileType python set omnifunc=pythoncomplete#Complete

map T :TaskList<CR>
map P :TlistToggle<CR>

noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>10 :20b<CR>
nnoremap <Leader>11 :21b<CR>
nnoremap <Leader>12 :22b<CR>
nnoremap <Leader>13 :23b<CR>
nnoremap <Leader>14 :24b<CR>
nnoremap <Leader>15 :25b<CR>
nnoremap <Leader>16 :26b<CR>
nnoremap <Leader>17 :27b<CR>
nnoremap <Leader>18 :28b<CR>
nnoremap <Leader>19 :29b<CR>
nnoremap <Leader>20 :20b<CR>
nnoremap <Leader>21 :21b<CR>
nnoremap <Leader>22 :22b<CR>
nnoremap <Leader>23 :23b<CR>
nnoremap <Leader>24 :24b<CR>
nnoremap <Leader>25 :25b<CR>
nnoremap <Leader>26 :26b<CR>
nnoremap <Leader>27 :27b<CR>
nnoremap <Leader>28 :28b<CR>
nnoremap <Leader>29 :29b<CR>
nnoremap <Leader>30 :30b<CR>

augroup filetypedetect
    au BufRead,BufNewFile *.eyaml set filetype=yaml
augroup END

" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Prettier on save
autocmd BufWritePre *.js Neoformat
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --tab-width\ 4
" Use formatprg when available
let g:neoformat_try_formatprg = 1

" Vimux run command"
map <Leader>vp :VimuxPromptCommand<CR>

"Check for ES6 Unused Imports"
nnoremap <leader>ji :w<CR>:call clearmatches()<CR>:let cmd = system('unused -v true ' . expand('%'))<CR>:exec cmd<CR>

"Run Flake8 Python Linter"
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_gutter=1
