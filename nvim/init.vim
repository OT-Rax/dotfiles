call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'pangloss/vim-javascript'
Plug 'puremourning/vimspector'
Plug 'lervag/vimtex'
call plug#end()

set autoindent
set history=50
set cmdheight=2
set updatetime=300
set shortmess+=c
set number
set signcolumn=number

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

filetype plugin indent on

let g:material_theme_style = 'palenight'

colorscheme material

if (has('termguicolors'))
  set termguicolors
endif

"packages
packadd vimball
