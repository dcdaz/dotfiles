"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
"           LightLine               "
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Author : Daniel Cordova           "
" E-Mail : danesc87@gmail.com       "
" Github : @dcdaz                   "
"""""""""""""""""""""""""""""""""""""

" Functions
function! ReadOnly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! Modified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! FileName()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return winwidth(0) > 70 ? filename . modified : ''
endfunction

function! FileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'No filetype') : ''
endfunction

function! FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! FileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! Mode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 70 ? lightline#mode() : ''
endfunction

" Configs
let g:unite_force_overwrite_statusline = 0
let g:lightline = {
            \ 'colorscheme': 'catppuccin_frappe',
      \ 'component_function': {
      \   'filename': 'FileName',
      \   'filetype': 'FileType',
      \   'fileencoding': 'FileEncoding',
      \   'fileformat': 'FileFormat',
      \   'mode': 'Mode',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode' ], [ 'filename' ] ],
      \   'right': [ ['lineinfo'], ['percent'], [ 'filetype', 'fileformat', 'fileencoding' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

