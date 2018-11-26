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
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'lepture/vim-jinja', { 'for': ['ruby.jinja2', 'yaml.ansible'] }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'Shougo/vimproc.vim', { 'for': 'typescript' }
Plug 'maralla/completor-typescript', { 'for': 'typescript' }
Plug 'maralla/completor.vim', { 'for': 'typescript' }
Plug 'prettier/vim-prettier'
Plug 'shime/vim-livedown'
Plug 'bling/vim-bufferline'
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'tmhedberg/SimpylFold'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
call plug#end()

" Prettier on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Prettier on save
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
    au BufRead,BufNewFile **/ansible/**.j2 set filetype=yaml.jinja
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
    au FileType markdown setlocal
augroup END

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

" Solarized pretty "
set background=dark
colorscheme solarized
