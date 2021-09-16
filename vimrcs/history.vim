if !isdirectory($HOME."/.vim/history")
    call mkdir($HOME."/.vim/history", "p", 0770)
endif

" Sets how many lines of history VIM has to remember
set history=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep backups, but keep them out of my way!
if !isdirectory($HOME."/.vim/history/backup")
    call mkdir($HOME."/.vim/history/backup", "p", 0700)
endif
set backup
set backupdir=~/.vim/history/backup
set backupcopy=no

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !isdirectory($HOME."/.vim/history/undodir")
    call mkdir($HOME."/.vim/history/undodir", "p", 0700)
endif
try
    set undodir=~/.vim/history/undodir
    set undofile
catch
endtry

