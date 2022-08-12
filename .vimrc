" the .vimrc is what makes vim good
" see `.vim/README.md` for plguin specific info
set nocompatible

set wildmenu
set laststatus=2
set hidden

syntax on
colorscheme deus
set nomodeline

" indentation
set expandtab
set softtabstop=2
set shiftwidth=0 " always match tabstop width
set autoindent
nnoremap LL :set! list<CR>

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

" file specific changes
au BufNewFile,BufRead Makefile set noexpandtab shiftwidth=4 softtabstop=-1 tabstop=4
au FileType go setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2


" # plugins

" install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" run :PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" running specific plugins
call plug#begin('~/.vim/plugged')

  " git
  Plug 'tpope/vim-fugitive'

  " nerd tree
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  map <C-n> :NERDTreeToggle<CR>

  " display marks on sidebar
  Plug 'kshenoy/vim-signature'

  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_section_y = 'BN: %n'
  let g:airline_section_z = '%l:%c'
  let g:airline_theme='deus'

  " language specific syntax highlighting
  Plug 'hashivim/vim-terraform'
  Plug 'tweekmonster/gofmt.vim'
  let g:gofmt_exe='/usr/local/go/bin/gofmt' " custom gofmt path

call plug#end()
