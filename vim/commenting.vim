" Custom manual commenting based on file extension
" Extra dictionary: filename-specific comment styles
let s:commentfilenames = {
\ 'Makefile': '#',
\ 'Dockerfile': '#',
\ '.bashrc': '#',
\ '.zshrc': '#',
\ '.profile': '#',
\ '.tmux.conf': '#',
\ '.vimrc': '"',
\ '.vim': '"',
\ 'Snakefile': '#',
\ '.gitignore': '#',
\ '.condarc': '#',
\ }

" Dictionary of comment characters by extension
let s:commentchars = {
\ 'c': '//',
\ 'cpp': '//',
\ 'h': '//',
\ 'java': '//',
\ 'py': '#',
\ 'py3': '#',
\ 'rs': '//',
\ 'hs': '--',
\ 'sh': '#',
\ 'bash': '#',
\ 'zsh': '#',
\ 'lua': '--',
\ 'go': '//',
\ 'js': '//',
\ 'ts': '//',
\ 'html': '<!--',
\ 'css': '/*',
\ 'swift': '//',
\ 'cabal': '--',
\ 'xml': '<!--',
\ 'xtce': '<!--',
\ }

" Helper to get comment string based on file extension
function! GetCommentChar()
  let l:ext = expand('%:e')     " get file extension
  let l:fname = expand('%:t')   " get filename (tail only)
  if l:ext != ''
    return get(s:commentchars, l:ext, '#')
  else
    return get(s:commentfilenames, l:fname, '#')
  endif
endfunction

" Comment a selected block
function! ManualCommentBlock()
  let l:cc = GetCommentChar()
  if l:cc == '<!--'
    silent '<,'>g/./s/^/<!-- / | silent '<,'>g/./s/$/ -->/
  else
    silent '<,'>g/./s/^/\=l:cc . ' '/
  endif
endfunction

" Comment current line
function! ManualCommentLine()
  let l:cc = GetCommentChar()
  if getline('.') =~ '\S'
    if l:cc == '<!--'
      execute 'normal! 0i<!-- '
      execute 'normal! A -->'
    else
      execute 'normal! 0i' . l:cc . ' '
    endif
  endif
endfunction

" Uncomment selected block
function! ManualUncommentBlock()
  let l:cc = GetCommentChar()
  if l:cc == '<!--'
    silent '<,'>s/^\s*<!--\s*//
    silent '<,'>s/\s*-->$//
  else
    execute "'<,'>s/^\\s*" . escape(l:cc, '#') . "\\s\\?//"
  endif
endfunction

" Uncomment current line
function! ManualUncommentLine()
  let l:cc = GetCommentChar()
  if l:cc == '<!--'
    execute 's/^\s*<!--\s*//'
    execute 's/\s*-->$//'
  else
    execute 's/^\s*' . escape(l:cc, '#') . '\s\?//'
  endif
endfunction

" Map the keys to call the functions
xnoremap gc :<C-u>call ManualCommentBlock()<CR>
nnoremap gc :call ManualCommentLine()<CR>
xnoremap gu :<C-u>call ManualUncommentBlock()<CR>
nnoremap gu :call ManualUncommentLine()<CR>

