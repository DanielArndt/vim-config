try
    colorscheme foursee
catch
endtry

" Git
au FileType gitcommit setlocal tw=72

" Show line numbers in tagbar
let g:tagbar_show_linenumbers = 1
" Close tagbar after selecting something
let g:tagbar_autoclose = 1

" Show tabs
set list

" Set visible characters for trailing spaces, tabs, and lines that continue off
" screen.
set listchars=trail:·,tab:>·,precedes:^,extends:$

" Don't go to the buffer when using ctrlp and the buffer is already open
" somewhere, open it in the current window
let g:ctrlp_jump_to_buffer = 0

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

" If there are mutiple tags, ask which one the user wants to jump to
nnoremap <C-]> g<C-]>

" 'Follow' a tag in a second window pane on the right
nnoremap <leader>] <C-w>o<C-w><C-v>g<C-]>zt

" Inserts a newline and aligns the text
nnoremap <leader><CR> i<CR><Esc>==

" Julia block-wise movement requires matchit
runtime macros/matchit.vim

let g:ycm_collect_identifiers_from_tags_files = 1

":let g:easytags_dynamic_files = 2
" Local replace
"
" nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" The above didn't work in Julia... but probably works in other languages.
nnoremap gr gd[[V][::s/<C-R>///gc<left><left><left>
" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

"------------------------------------------------------------------------------
" Vim-go
"------------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1

" Show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor
au FileType go nmap <Leader>i <Plug>(go-info)

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Run/build/test/coverage
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>gi <Plug>(go-install)
" By default syntax-highlighting for Functions, Methods and Structs is disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

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

" Show line numbers
set number

" Set a long line marker at the same location as textwidth
set colorcolumn=+1
" Highlight current line - allows you to track cursor position more easily
set cursorline
" Automatically indent when moving to a new line
set autoindent

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Enable mouse detection for a larger area
if !has('nvim')
  set ttymouse=sgr
endif

" Allow C-a increment in visual mode... just increase each number.
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  execute 'normal! '.c.'|'."\<C-a>"
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>
function! Decr()
  let c = virtcol("'<")
  execute 'normal! '.c.'|'."\<C-x>"
  normal `<
endfunction
vnoremap <C-x> :call Decr()<CR>

" Only be case sensitive when typing a search manually.
set smartcase

" New splits appear to the right, and below
set splitbelow
set splitright

" Keep backups, but keep them out of my way!
set backup
set backupdir=~/.vim_runtime/backup
set directory=~/.vim_runtime/backup
set backupcopy=no

" I don't ever use ex mode, get out of my way!
nnoremap Q <nop>

" Toggle paste mode with F2
set pastetoggle=<F2>

" Refresh
map <F5> :e!<CR>:syntax sync fromstart<CR>
imap <F5> <C-o><F5>

" Stop vimpager from FREAKING out
if exists("g:vimpager.enabled")
    " Disable all the vim-less bindings. They're the worst.
    let g:vimpager = {}
    let g:less     = {}
    let g:less.enabled = 0
    " q quits, even if changed (if file is too long, truncation is a change)
    map q :q!<CR>
    " Set read-only, non-modifiable buffer
    set nomodifiable
    set nonumber
    " Don't show trailing chars
    highlight ExtraWhitespace none
endif

" CtrlP tags browsing
let g:ctrlp_extensions = ['tag']
noremap <leader>u :CtrlPTag<CR>

" Ctrl-w Ctrl-w goes to last window. Who the hell wants to cycle?
noremap <C-w><C-w> <C-w><C-p>

" Ctrl-w Ctrl-e closes all quickfix and preview windows
" Conflicts with <C-w> (delete back a word) inoremap <C-w><C-e> <C-o>:cclose<CR><C-o>:pclose<CR>
noremap <C-w><C-e> :cclose<CR>:pclose<CR>

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


" Re-reformat paragraph (align to text width).
" TODO: I want C-/  but keyboard sends C-_. Is C-_ just this crazy keyboard?
noremap <C-_> {v}gq<C-o><C-o>

" Avoid weird behaviour where nerdtree opens full screen
noremap <leader>ba :NERDTreeClose<CR>:bufdo bd<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket/quotes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap `` <esc>`>a``<esc>`<i``<esc>

noremap <leader>q <C-w>q

nmap <F9> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out<CR>
  \:cs reset<CR>

" map <C-c> :!sl<CR><CR>
" imap <C-c> <ESC>:!sl<CR><CR>
"
syntax sync minlines=200
" set clipboard=unnamedplus

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
hi FoldColumn ctermfg=Yellow
