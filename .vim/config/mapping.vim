"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
"         Mapping Configs           "
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Author : Daniel Cordova           "
" E-Mail : danesc87@gmail.com       "
" Github : @dcdaz                   "
"""""""""""""""""""""""""""""""""""""

" Lazy mappings
nnoremap 1 :NERDTreeToggle<CR>
nnoremap 2 :TagbarToggle<CR>
nnoremap 3 :call ToggleWrap()<CR>
nnoremap 4 :MinimapToggle<CR>

" Paste and Select All
noremap <C-v> "+gP
noremap <C-a> ggVG

" Undo in INSERT Mode
inoremap <C-z> <Esc>ui

" Tabs
noremap za :tabnew<CR>
noremap zx gt
noremap zz gT

" Visual Block
nnoremap vb <C-v>

" Move between panes
noremap <A-Left> <C-w>h
noremap <A-Right> <C-w>l
noremap <A-Up> <C-w>k
noremap <A-Down> <C-w>j
inoremap <A-Left> <Esc><C-w>h
inoremap <A-Right> <Esc><C-w>l
inoremap <A-Up> <Esc><C-w>k
inoremap <A-Down> <Esc><C-w>j

" Splitting and resizing Panes
noremap <C-\> :vsplit<CR>
noremap <Esc>\ :split<CR>
noremap 0 :vertical resize +1<CR>
noremap 9 :vertical resize -1<CR>
noremap ) :resize +1<CR>
noremap ( :resize -1<CR>
inoremap <C-\> <Esc>:vsplit<CR>
inoremap <Esc>\ <Esc>:split<CR>

" Open terminal in NORMAL and INSERT mode and Move to/from it
noremap <C-^> :below terminal<CR>
inoremap <C-^> :below terminal<CR>
tnoremap <A-Up> <C-w>k

" NERDCommenter Comment line
nmap <C-_> <leader>c<Space>
imap <C-_> <leader>c<Space>

" LSP Pumvisible and Vim-Snip
inoremap <C-Space> <C-n>
" inoremap <C-@> <C-Space>
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
inoremap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
noremap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
inoremap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
noremap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" If you need more configs for snippets you cahn check https://github.com/hrsh7th/vim-vsnip

" Format Json and XML
nnoremap fj :set syntax=json \| %!python3 -m json.tool<CR>
nnoremap fx :set syntax=xml \| %!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<CR>

