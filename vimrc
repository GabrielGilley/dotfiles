set number
set noerrorbells
set novisualbell
set t_vb=
set belloff=all
"set mouse=a
"set ttymouse=xterm
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set expandtab
set nohlsearch
set autoindent
set modeline
set modelines=30
 
map gr gT
 
map <Home> ^
 
 
 
"=====[ Highlight matches when jumping to next ]=============
    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.1)<cr>
    nnoremap <silent> N   N:call HLNext(0.1)<cr>
    " OR ELSE just highlight the match in red...
    function! HLNext (blinktime)
        highlight WhiteOnRed ctermfg=white ctermbg=red
        highlight RedOnWhite ctermfg=red ctermbg=white
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        "exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        "call matchdelete(ring)"
        "redraw
        "exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        "let ring = matchadd('WhiteOnRed', target_pat, 101)
        "redraw
        "exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        "call matchdelete(ring)"
        "redraw
    endfunction
 
 
 
" Function: s:TextEnableCodeSnip() {{{2
" Highlight section of file
function! s:TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction
 
 
" Section: Commands {{{1
com! SpaceHi call s:SpaceHi()
com! NoSpaceHi call s:NoSpaceHi()
com! ToggleSpaceHi call s:ToggleSpaceHi()
com! TextEnableCodeSnipPy call s:TextEnableCodeSnip(  'python',   'RUN Python ON ',   '\nDONE', 'SpecialComment')
com! TextEnableCodeSnipLocalPy call s:TextEnableCodeSnip(  'python',   'RUN LocalPython ON ',   '\nDONE', 'SpecialComment')
com! TextEnableCodeSnipSh call s:TextEnableCodeSnip(  'sh',   'RUN Shell ON ',   '\nDONE', 'SpecialComment')
augroup test_group
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax,Filetype * TextEnableCodeSnipSh
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax,Filetype * TextEnableCodeSnipPy
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax,Filetype * TextEnableCodeSnipLocalPy
autocmd BufRead,BufNewFile MANIFEST set filetype=json
augroup end
 
 
"Very similar to colorscheme ron"
:set bg=dark
:set ai
:set et
:set ts=4
:set sw=4
 
:set nu
 
syntax on
autocmd BufRead,BufNewFile MANIFEST set filetype=yaml
autocmd BufRead,BufNewFile firewheel-ssh-config set filetype=sshconfig
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
endif


syntax on
syntax include @sh syntax/sh.vim
syntax region shSnip matchgroup=Snip start="@begin=sh@" end="@end=sh@" contains=@sh
hi link Snip SpecialComment
syn match Keyword '<<<'
" hi TabLineSel ctermbg=Yellow
hi TabLineSel ctermbg=DarkYellow
 
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
"guibg=NONE guifg=NONE
highlight CursorLineNR ctermbg=darkyellow
set cursorline
highlight LineNr ctermfg=darkgrey
 
" Avoid command-line redraw on every entered character by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
set noarabicshape
endif
 
au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim
 
set tabpagemax=50
set cursorline
highlight Cursorline term=bold cterm=bold guibg=Grey40

source ~/.vim/commenting.vim
source ~/.vim/clipboard.vim
source ~/.vim/surround.vim
