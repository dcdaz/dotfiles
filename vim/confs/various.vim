" Confs for some plugins
let g:cpp_class_scope_highlight           = 1
let g:cpp_experimental_template_highlight = 1
let c_no_curly_error                      = 1

set regexpengine=1
set laststatus=2
autocmd FileType apache setlocal commentstring=#\ %s
autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif


" Javascript
let g:javascript_enable_domhtmlcss      = 1
let g:javascript_ignore_javaScriptdoc   = 1
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

let g:sol = {
	\"gui": {
		\"base03": "#002b36",
		\"base02": "#073642",
		\"base01": "#586e75",
		\"base00": "#657b83",
		\"base0": "#839496",
		\"base1": "#93a1a1",
		\"base2": "#eee8d5",
		\"base3": "#fdf6e3",
		\"yellow": "#b58900",
		\"orange": "#cb4b16",
		\"red": "#dc322f",
		\"magenta": "#d33682",
		\"violet": "#6c71c4",
		\"blue": "#268bd2",
		\"cyan": "#2aa198",
		\"green": "#719e07"
	\},
	\"cterm": {
		\"base03": 8,
		\"base02": 0,
		\"base01": 10,
		\"base00": 11,
		\"base0": 12,
		\"base1": 14,
		\"base2": 7,
		\"base3": 15,
		\"yellow": 3,
		\"orange": 9,
		\"red": 1,
		\"magenta": 5,
		\"violet": 13,
		\"blue": 4,
		\"cyan": 6,
		\"green": 2
	\}
\}

function! DeviconsColors(config)
	let colors = keys(a:config)
	augroup devicons_colors
		autocmd!
		for color in colors
			if color == 'normal'
				exec 'autocmd FileType nerdtree,startify if &background == ''dark'' | '.
					\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
					\ 'else | '.
					\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
					\ 'endif'
			elseif color == 'emphasize'
				exec 'autocmd FileType nerdtree,startify if &background == ''dark'' | '.
					\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
					\ 'else | '.
					\ 'highlight devicons_'.color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
					\ 'endif'
			else
				exec 'autocmd FileType nerdtree,startify highlight devicons_'.color.' guifg='.g:sol.gui[color].' ctermfg='.g:sol.cterm[color]
			endif
			exec 'autocmd FileType nerdtree,startify syntax match devicons_'.color.' /\v'.join(a:config[color], '|').'/ containedin=ALL'
		endfor
	augroup END
endfunction




let g:devicons_colors = {
            \'normal': ['', '', '', '', ''],
			\'emphasize': ['', '', '', '', '', '', '', '', '', '', ''],
			\'yellow': ['', '', ''],
			\'orange': ['', '', '', 'λ', '', ''],
			\'red': ['', '', '', '', '', '', '', '', ''],
			\'magenta': [''],
			\'violet': ['', '', '', ''],
			\'blue': ['', '', '', '', '', '', '', '', '', '', '', '', ''],
			\'cyan': ['', '', '', ''],
			\'green': ['', '', '', '']
            \}

call DeviconsColors(g:devicons_colors)
