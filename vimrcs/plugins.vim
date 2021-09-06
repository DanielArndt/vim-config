" Don't go to the buffer when using ctrlp and the buffer is already open
" somewhere, open it in the current window
let g:ctrlp_jump_to_buffer = 0

" Close tagbar after selecting something
let g:tagbar_autoclose = 1

" Kill buffers in Ctrl-P with Ctrl-q
" https://github.com/kien/ctrlp.vim/issues/280
let g:ctrlp_buffer_func = { 'enter': 'CtrlPEnter' }
func! CtrlPEnter()
  nnoremap <buffer> <silent> <C-q> :call <sid>CtrlPDeleteBuffer()<cr>
endfunc
func! s:CtrlPDeleteBuffer()
  let line = getline('.')
  let bufid = line =~ '\[\d\+\*No Name\]$' ?
    \ str2nr(matchstr(line, '\d\+')) :
    \ fnamemodify(line[2:], ':p')
  exec "bd" bufid
  exec "norm \<F5>"
endfunc

let g:ycm_collect_identifiers_from_tags_files = 1

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------

" General properties
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
let NERDTreeWinSize = 35

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
"let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" Close NERDTree after opening a file
let NERDTreeQuitOnOpen=1

" Tagbar
map <leader>tb :TagbarToggle<CR>

" CtrlP tags browsing
let g:ctrlp_extensions = ['tag']
noremap <leader>u :CtrlPTag<CR>

" Flake8 - Show me python errors as soon as I save
function Flake8ifexists()
    if executable("flake8")
        call Flake8()
    endif
endfunction

autocmd BufWritePost *.py call Flake8ifexists()
let g:flake8_show_quickfix=0  " don't show
let g:flake8_show_in_gutter=1  " show in gutter instead

let g:bookmark_auto_close=1 " Auto close bookmark window
let g:bookmark_manage_per_buffer=1

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""
" => UltiSnips
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>
