"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
"    Personal VIM Configuration     "
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Author : Daniel Cordova           "
" E-Mail : danesc87@gmail.com       "
" Github : @dcdaz                   "
"""""""""""""""""""""""""""""""""""""

" Basic Confs
set encoding=utf-8
set number
set expandtab
set tabstop=4
set cindent
set shiftwidth=4
set mouse=a
set ruler
set showcmd
set title
set nocp
set noshowmode
set hlsearch
set ignorecase
set smartcase
set laststatus=2
set backspace=indent,eol,start
set term=xterm-256color
set termwinsize=10x0
set splitbelow
set splitright
au InsertLeave * set nopaste
syntax on

" Vim Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin', {'on':  'NERDTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'severin-lemaignan/vim-minimap', {'on': []}
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'puremourning/vimspector',{'for': ['rust','c','cpp','python','javascript']} 
call plug#end()

" Colorscheme and Font
silent! colorscheme dracula
set guifont=Inconsolata\ Nerd\ Font\ Mono\ 12

" Misc
source ~/.vim/config/misc.vim
" Pastemode
source ~/.vim/config/pastemode.vim
" Lightline
source ~/.vim/config/lightline.vim
" LSP
source ~/.vim/config/lsp.vim
" Mapping
source ~/.vim/config/mapping.vim

