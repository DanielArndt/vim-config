"------------------------------------------------------------------------------
" YouCompleteMe
"------------------------------------------------------------------------------
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

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

"------------------------------------------------------------------------------
" Tagbar
"------------------------------------------------------------------------------
map <leader>tb :TagbarToggle<CR>
" Close tagbar after selecting something
let g:tagbar_autoclose = 1

"------------------------------------------------------------------------------
" Bookmarks
"------------------------------------------------------------------------------
let g:bookmark_auto_close=1 " Auto close bookmark window
let g:bookmark_manage_per_buffer=1

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
" Don't go to the buffer when using ctrlp and the buffer is already open
" somewhere, open it in the current window
let g:ctrlp_jump_to_buffer = 0

" Use git for ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

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

" CtrlP tags browsing
let g:ctrlp_extensions = ['tag']
noremap <leader>u :CtrlPTag<CR>

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

" This seems to make the cursor not move forward when pressing `.` for some reason
" TODO: Figure out why, and see if this can be re-enabled
let g:pymode_rope = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terraform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoformat terraform:
let g:terraform_fmt_on_save=1
let g:terraform_align=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Local Vim RC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reload .lvimrc if 'Y' was given as answer (not 'y')
let g:localvimrc_persistent = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_python_pylsp_executable = "pylsp"
let g:ale_python_pylsp_auto_poetry = 1

let g:ale_python_pylsp_config = {
\   'pylsp': {
\     'plugins': {
\       'pycodestyle': {
\         'enabled': v:false,
\       },
\       'pyflakes': {
\         'enabled': v:false,
\       },
\       'pydocstyle': {
\         'enabled': v:false,
\       },
\     },
\   },
\}
