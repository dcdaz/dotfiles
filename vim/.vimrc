"""""""""""""""""""""""""""""""""""""
"                                   "
" This is my personal configuration "
" Daniel Cordova A.                 "
"                                   "
"""""""""""""""""""""""""""""""""""""

"""""""""""""""
" Basic Confs "
"""""""""""""""

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
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" Make 'Backspace' key work propely on some vim instances
set backspace=indent,eol,start
" Make Ctrl-Arrows work well
set term=xterm-256color
syntax on
" Vim tell Leave INSERT mode
au InsertLeave * set nopaste

"""""""""""""""""""""""""""
" Vim-Plug plugin manager "
"""""""""""""""""""""""""""

" Install vim-plug and plugins only if there aren't present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/vim-plugins')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'alvan/vim-closetag'
Plug 'severin-lemaignan/vim-minimap', {'on': []}
Plug 'smancill/conky-syntax.vim', {'for': 'conky'}
Plug 'udalov/kotlin-vim', {'for': 'kotlin'}
Plug 'peterhoeg/vim-qml', {'for': 'qml'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'dracula/vim', { 'as': 'dracula' }
" Initialize plugin system
call plug#end()

"""""""""""
" Sources "
"""""""""""

" Various Confs
source ~/.vim/confs/various.vim
" Custom Functions
source ~/.vim/confs/custom-functions.vim
" Pastemode automatically
source ~/.vim/confs/pastemode.vim
" Lightline
source ~/.vim/confs/lightline.vim
" Nerd Stuff
source ~/.vim/confs/nerd-stuff.vim

""""""""""""""""
" OmniComplete "
""""""""""""""""

" Syntax completion
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest,menuone
" Popup Menu config
highlight Pmenu ctermbg=236 ctermfg=250 guibg=#313131 guifg=#D6D6D6

"""""""""""""""""""""
" Mapping Shortcuts "
"""""""""""""""""""""

" Lazy mappings
map 1 :NERDTreeToggle<CR>
map 2 :TagbarToggle<CR>
" Toggle wrapping long text
map 3 :call ToggleWrap()<CR>
" ShortCut MiniMap
map 4 :MinimapToggle<CR>

" Visual Block
nnoremap vb <C-v>

" Tabs
" Create new Tab
map za :tabnew<CR>
" Move to the right tab
map zx gt
" Move to the left tab
map zz gT

" Simple Behavior
" Paste text from clipboard with 'Ctrl+v'
map <C-v> "+gP
" Select all text with 'Ctrl+a'
map <C-a> ggVG
" Format Json
nmap fj :set syntax=json \| %!python3 -m json.tool<CR>
" Format XML
nmap fx :set syntax=xml \| %!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<CR>
" Move between panes in NORMAL and INSERT modes
nmap <A-Left> <C-w>h
nmap <A-Right> <C-w>l
nmap <A-Up> <C-w>k
nmap <A-Down> <C-w>j
imap <A-Left> <Esc><C-w>h
imap <A-Right> <Esc><C-w>l
imap <A-Up> <Esc><C-w>k
imap <A-Down> <Esc><C-w>j
"Move from below terminal to editor
tnoremap <A-Up> <C-w>k

" NERDCommenter
" Toggle Comment line or selected text with 'Ctrl+/'
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" Omnicompletion
imap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
imap <C-k> <c-r>=SmartOmniComplete()<CR>

