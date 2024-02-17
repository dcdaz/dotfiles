"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
"            LSP Configs            "
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""
" Author : Daniel Cordova           "
" E-Mail : danesc87@gmail.com       "
" Github : @dcdaz                   "
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""
" Syntax Completion "
"""""""""""""""""""""

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,preview
" Popup Menu config
highlight Pmenu ctermbg=236 ctermfg=250 guibg=#313131 guifg=#D6D6D6

""""""""""""""
" Vimspector "
""""""""""""""

let g:vimspector_enable_mappings = 'HUMAN'
" let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
" let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB' ]
let g:vimspector_install_gadgets = ['CodeLLDB']
let g:vimspector_base_dir=expand('$HOME/.vim/vimspector-config')

