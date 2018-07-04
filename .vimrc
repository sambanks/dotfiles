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
set ignorecase
set smartcase
set bg=dark
set relativenumber
set foldmethod=indent
set foldlevel=99

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
Plugin 'shime/vim-livedown'
Plugin 'bling/vim-bufferline'
Plugin 'junegunn/fzf'
Plugin 'tell-k/vim-autopep8'
Plugin 'sbdchd/neoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'nvie/vim-flake8'
Plugin 'majutsushi/tagbar'
Plugin 'tmhedberg/SimpylFold'
Plugin 'pearofducks/ansible-vim'
Plugin 'lepture/vim-jinja'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required

" ** JS **
" Prettier on save
augroup filetype_js
    au!
    au BufWritePre *.js Neoformat
    au FileType javascript setlocal formatprg=prettier\ --stdin\ --tab-width\ 4
augroup END
" Use formatprg when available
let g:neoformat_try_formatprg = 1
" Check for ES6 Unused Imports"
nnoremap <leader>ji :w<CR>:call clearmatches()<CR>:let cmd = system('unused -v true ' . expand('%'))<CR>:exec cmd<CR>
" Check jsx in js files "
let g:jsx_ext_required = 0

" ** PYTHON **
"Run Flake8 Python Linter"
augroup filetype_python
    au!
    au FileType python set omnifunc=pythoncomplete#Complete
augroup END
let g:flake8_show_in_gutter=1
"Disable import-error for AP wrappers
let g:syntastic_python_pylint_post_args='--disable=import-error'

" ** RUBY (Puppet & Vagrant) **
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}
augroup filetype_ruby
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
    au Filetype ruby setlocal ts=2 sw=2 expandtab
augroup END

" ** YAML **
" Detect eyaml as yaml
augroup filetype_yaml
    au!
    au BufRead,BufNewFile *.eyaml set filetype=yaml
    au FileType yaml setlocal ts=2 sw=2
augroup END

" ** Ansible **
" Detect Ansible Files
augroup filetype_ansible
    au!
    au BufRead,BufNewFile */ansible/*.yaml set filetype=yaml.ansible
    au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
    au BufRead,BufNewFile *.j2 set filetype=ruby.jinja2
    au FileType ansible setlocal ts=2 sw=2
    au FileType jinja setlocal ts=2 sw=2
augroup END

" ** JSON **
augroup filetype_json
    au!
    au FileType json setlocal ts=2 sw=2
augroup END

" ** Markdown **
augroup filetype_md
    au!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    au BufWritePre *.md Neoformat
    au FileType markdown setlocal formatprg=prettier\ --stdin\ --tab-width\ 4\ --prose-wrap\ always
augroup END

noremap gp :silent %!/home/sbanks/git/finis/Code/app/venv/bin/prettier\ --stdin\ --tab-width\ 4\ --prose-wrap\ always\ --parser\ markdown<CR>

" ** SYNTASTIC **
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
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

" ** AIRLINE **
" Only load extensions I want
let g:airline_extensions = [ 
  \ 'branch', 'syntastic'
  \ ]
" Cut out sections I don't want
let g:airline_section_a = ''
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ], [ 'z', 'error', 'warning' ]
  \ ]
" Buffer extension
let g:airline#extensions#bufferline#enabled = 1
" For speed
let g:airline_highlighting_cache = 0

" ** Keyboard Mappings **
" Toggle Tagbar "
map <Leader>t :TagbarToggle<CR>
" Enable folding with the spacebar
nnoremap <space> za

" Highlight long lines "
augroup vimrc_autocmds
    au!
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
    autocmd BufEnter * match OverLength /\%82v.*/
augroup END

" Solarized pretty "
set background=dark
colorscheme solarized
