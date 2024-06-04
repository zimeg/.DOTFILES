" the .vimrc is what makes vim good
set nocompatible

set wildmenu
set laststatus=2
set hidden

syntax on
set nomodeline

" indentation
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
nnoremap LL :if &list \| set nolist \| else \| set list \| endif<CR>

" better searching
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap HH :silent! nohls<CR>

" fancy line numbers
set number relativenumber
set nu rnu

" silent vim
set visualbell
set t_vb=

" quick espace
imap kj <Esc>

" quick jumps
map <C-u> <C-u>zz
map <C-d> <C-d>zz
