" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

runtime vimrcs/functions.vim
runtime vimrcs/plugins.vim
runtime vimrcs/interface.vim
runtime vimrcs/history.vim
runtime vimrcs/editor.vim
runtime vimrcs/keybindings.vim

" Initial setup:
if !isdirectory($HOME."/.vim/temp_dirs")
    call mkdir($HOME."/.vim/temp_dirs", "p")
endif
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif

" Enable filetype plugins
filetype plugin on
filetype indent on



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

" I don't ever use ex mode, get out of my way!
nnoremap Q <nop>


"""""""""
" F-keys
"""""""""
" Toggle paste mode with F2
set pastetoggle=<F2>
" Refresh
map <F5> :e!<CR>:syntax sync fromstart<CR>
imap <F5> <C-o><F5>

" Ctrl-w Ctrl-w goes to last window. Who the hell wants to cycle?
noremap <C-w><C-w> <C-w><C-p>

" Ctrl-w Ctrl-e closes all quickfix and preview windows
" Conflicts with <C-w> (delete back a word) inoremap <C-w><C-e> <C-o>:cclose<CR><C-o>:pclose<CR>
noremap <C-w><C-e> :cclose<CR>:pclose<CR>

" Re-reformat paragraph (align to text width).
" TODO: I want C-/  but keyboard sends C-_. Is C-_ just this crazy keyboard?
noremap <C-_> {v}gq<C-o><C-o>

" Close all buffers
" Avoid weird behaviour where nerdtree opens full screen
noremap <leader>ba :NERDTreeClose<CR>:bufdo bd<CR>


" Surround text in double ticks
vnoremap `` <esc>`>a``<esc>`<i``<esc>

syntax sync minlines=200
hi FoldColumn ctermfg=Yellow

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>e :e! ~/.vim/local/local_config.vim<cr>
autocmd! bufwritepost vimrc source ~/.vim_runtime/local/local_config.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%y/%m/%d %H:%M:%S")<cr>