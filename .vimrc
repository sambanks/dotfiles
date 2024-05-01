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
Plug 'editorconfig/editorconfig-vim'
Plug 'github/copilot.vim'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/vim-plug'
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

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

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
command! -nargs=0 Prettier :CocCommand prettier.formatFile --print-width 80

" ** JSON **
augroup filetype_json
    au!
    au FileType json setlocal ts=2 sw=2
augroup END

" ** Terraform **
let g:terraform_fmt_on_save = 1

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
