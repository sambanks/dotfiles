" ** Defaults **
set nocompatible
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

" ** Vundle **
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Install other Plugins
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
Plugin 'majutsushi/tagbar'
call vundle#end()            " required

" ** JS **
" Prettier on save
autocmd BufWritePre *.js Neoformat
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --tab-width\ 4
" Use formatprg when available
let g:neoformat_try_formatprg = 1
" Check for ES6 Unused Imports"
nnoremap <leader>ji :w<CR>:call clearmatches()<CR>:let cmd = system('unused -v true ' . expand('%'))<CR>:exec cmd<CR>
" Check jsx in js files "
let g:jsx_ext_required = 0

" ** PYTHON **
"Run Flake8 Python Linter"
autocmd BufWritePost *.py call Flake8()
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:flake8_show_in_gutter=1

" ** RUBY (Puppet) **
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" ** YAML **
" Detect eyaml as yaml
augroup filetypedetect
    au BufRead,BufNewFile *.eyaml set filetype=yaml
augroup END

" ** SYNTASTIC **
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
" Add warnings to status bar
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" ** Keyboard Mappings **
" Nav splits
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l
" Vimux run command"
map <Leader>vp :VimuxPromptCommand<CR>
" Toggle Tagbar "
map <Leader>t :TagbarToggle<CR>

" ** MiniBuffExplorer **
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

