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

" Load MiniMap
call plug#load('vim-minimap')
let g:minimap_highlight='Visual'

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](target|build|.git)$',
  \ 'file': '\v\.(d|so|swp|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Dev-Icons
" To install vim-devicons you need nerd fonts https://github.com/ryanoasis/nerd-fonts you
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

""""""""""""""
" NERD Stuff "
""""""""""""""

" NERD Tree
let g:NERDTreeWinSize = '30'
" Open NERDTree automatically when vim starts up in a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim when NERDTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" Disable weird color on folders
highlight! link NERDTreeFlags NERDTreeDir
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName    = 1
let g:NERDTreePatternMatchHighlightFullName  = 1
let g:NERDTreeHighlightFolders               = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName       = 1 " highlights the folder name
let g:NERDTreeLimitedSyntax                  = 1
let g:NERDTreeHighlightCursorline            = 0

" NERD Commenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" NERD Git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

""" Git Gutter
let g:gitgutter_git_executable = 'git'
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '+-'
let g:gitgutter_sign_removed = '--'

" Function for toggle wrapping text on Vim
function ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
endfunction
