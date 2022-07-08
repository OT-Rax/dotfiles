call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'pangloss/vim-javascript'
Plug 'puremourning/vimspector'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
call plug#end()

set autoindent
set history=50
set cmdheight=2
set updatetime=300
set shortmess+=c
set number
set signcolumn=number

au BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <silent> <C-f> :Files<CR>

augroup Latex
	autocmd FileType tex nnoremap <C-p> :!mupdf %:p:r.pdf & disown<CR>
	autocmd FIleType tex nnoremap <C-l> :!pdflatex %:p && latexmk -c<CR>
augroup end

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
