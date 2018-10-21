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
set bg=dark
set relativenumber
set foldmethod=indent
set foldlevel=99
set laststatus=2
set noshowmode

" ** Vundle **
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Install other Plugins
Plugin 'pangloss/vim-javascript'
Plugin 'isRuslan/vim-es6'
Plugin 'mxw/vim-jsx'
Plugin 'shime/vim-livedown'
Plugin 'bling/vim-bufferline'
Plugin 'junegunn/fzf'
Plugin 'tell-k/vim-autopep8'
Plugin 'sbdchd/neoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'airblade/vim-gitgutter'
Plugin 'nvie/vim-flake8'
Plugin 'majutsushi/tagbar'
Plugin 'tmhedberg/SimpylFold'
Plugin 'pearofducks/ansible-vim'
Plugin 'lepture/vim-jinja'
Plugin 'altercation/vim-colors-solarized'
Plugin 'itchyny/lightline.vim'
Plugin 'w0rp/ale'
Plugin 'leafgarland/typescript-vim'

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

" ** RUBY (Puppet & Vagrant) **
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

" ** JINJA **
" Detect eyaml as yaml
augroup filetype_yaml
    au!
    au BufRead,BufNewFile *.j2 set filetype=ruby.jinja2
    au FileType yaml setlocal ts=2 sw=2
augroup END



" ** Ansible **
" Detect Ansible Files
augroup filetype_ansible
    au!
    au BufRead,BufNewFile **/ansible/**.yaml set filetype=yaml.ansible
    au BufRead,BufNewFile **/ansible/**.yml set filetype=yaml.ansible
    au BufRead,BufNewFile **/ansible/**.j2 set filetype=yaml.ansible
    au BufRead,BufNewFile *.j2 set filetype=ruby.jinja2
    au FileType yaml.ansible setlocal ts=2 sw=2
    au FileType yaml.jinja setlocal ts=2 sw=2
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



" Add warnings to status bar
set statusline+=%#warningmsg#
set statusline+=%*

" ** Lightline **
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {    
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" ** Keyboard Mappings **
" Toggle Tagbar "
map <Leader>t :TagbarToggle<CR>
" Enable folding with the spacebar
nnoremap <space> za

" Solarized pretty "
set background=dark
colorscheme solarized
