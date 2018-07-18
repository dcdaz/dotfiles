"Confs for some plugins
autocmd FileType apache setlocal commentstring=#\ %s
autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
let g:NERDTreeWinSize = '30'
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error=1
set regexpengine=1
set laststatus=2
let g:javascript_enable_domhtmlcss = 1
let g:javascript_ignore_javaScriptdoc = 1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

"Closetags
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

"Dev-Icons
"To install vim-devicons it's necessary some patched fonts to make it work
"perfectly in this github repo https://github.com/ryanoasis/nerd-fonts you
"have some patched fonts and glyph fonts for this
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsDefaultFolderOpenSymbol = 'Π'
let g:WebDevIconsOS = 'unix'
