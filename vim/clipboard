" Normal Mode mappings
nnoremap <Leader>y :call CopyLineToClipboard()<CR>
nnoremap <Leader>d :call CutLineToClipboard()<CR>

" Visual Mode mappings
xnoremap <Leader>y :<C-u>call CopyVisualToClipboard()<CR>
xnoremap <Leader>d :<C-u>call CutVisualToClipboard()<CR>

" --- Clipboard Copy Functions ---

" Auto-detect correct clipboard command
function! GetClipboardCommand()
  if has('mac')
    return 'pbcopy'
  elseif executable('xclip')
    return 'xclip -selection clipboard'
  elseif executable('wl-copy')
    return 'wl-copy'
  else
    return ''
  endif
endfunction

" Wrapper to actually send text to system clipboard
function! SendToClipboard(text)
  let l:cmd = GetClipboardCommand()
  if l:cmd == ''
    echo "No clipboard tool available!"
  else
    call system(l:cmd, a:text)
    echo "Copied to system clipboard."
  endif
endfunction

" Copy one line
function! CopyLineToClipboard()
  let l:line = getline('.')
  call SendToClipboard(l:line . "\n")
endfunction

" Cut one line
function! CutLineToClipboard()
  let l:line = getline('.')
  call SendToClipboard(l:line . "\n")
  normal! dd
endfunction

" Copy visual block
function! CopyVisualToClipboard()
  let l:start = getpos("'<")[1]
  let l:end = getpos("'>")[1]
  let l:lines = getline(l:start, l:end)
  call SendToClipboard(join(l:lines, "\n") . "\n")
endfunction

" Cut visual block
function! CutVisualToClipboard()
  let l:start = getpos("'<")[1]
  let l:end = getpos("'>")[1]
  let l:lines = getline(l:start, l:end)
  call SendToClipboard(join(l:lines, "\n") . "\n")
  normal! gvd
endfunction
