" Set Paste Automatically
" This configuration works with tmux
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"
  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"For non tmux users uncomment the following lines and comment the first ones

"let &t_SI .= '"\<Esc>[?2004h"
"set &t_EI .= '"\<Esc>[?2004l"
"
"inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"
"function! XTermPasteBegin()
"  set pastetoggle=<Esc>[201~
"  set paste
"  return '""
"endfunction
