"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
"           Various Configs         "
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""
" Author : Daniel Cordova           "
" E-Mail : danesc87@gmail.com       "
" Github : @dcdaz                   "
"""""""""""""""""""""""""""""""""""""

" Colorscheme and Font
colorscheme dracula
set guifont=Inconsolata\ Nerd\ Font\ Mono\ 12

" Load MiniMap
call plug#load('vim-minimap')
let g:minimap_highlight='Visual'

" Some CPP configs
let g:cpp_class_scope_highlight           = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error                      = 1

set regexpengine=1
set laststatus=2

" RUST configs
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" Closetags
let g:closetag_filenames               = "*.html,*.xhtml,*.phtml,*.xml"
let g:closetag_xhtml_filenames         = '*.xhtml,*.jsx'
let g:closetag_filetypes               = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes         = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut                = '>'

"""""""""""""
" Dev-Icons "
"""""""""""""

" To install vim-devicons it's necessary some patched fonts to make it work
" perfectly in this github repo https://github.com/ryanoasis/nerd-fonts you
" have some patched fonts and glyph fonts for this
let g:webdevicons_enable                               = 1
let g:webdevicons_enable_nerdtree                      = 1
let g:webdevicons_conceal_nerdtree_brackets            = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign          = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth               = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding             = ' '
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
let g:WebDevIconsUnicodeDecorateFolderNodes            = 1
let g:DevIconsDefaultFolderOpenSymbol                  = 'Π'
let g:DevIconsEnableFoldersOpenClose                   = 1
let g:DevIconsEnableFolderExtensionPatternMatching     = 1
let g:WebDevIconsOS                                    = 'unix'
" Disable weird color on folders
highlight! link NERDTreeFlags NERDTreeDir

