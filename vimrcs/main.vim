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

" Enable filetype plugins
filetype plugin on
filetype indent on

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
noremap <leader>ba :NERDTreeClose<CR>:bufdo bd<CR>:echo "Closed all buffers"<CR>
" kill-all but visible buffers
func! Clean_buffers()
    let l:buffers = filter(getbufinfo(), {_, v -> v.hidden})
    if !empty(l:buffers)
        execute 'bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
    endif
endfunc
" kill-all but visible buffers
nnoremap <silent> <leader>bc :call Clean_buffers()<CR>:echo "Cleaned up all hidden buffers"<CR>


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
autocmd! bufwritepost vimrc source ~/.vim/local/local_config.vim

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
iab xdate <c-r>=strftime("%d %b %Y")<cr>
iab xdatet <c-r>=strftime("%y/%m/%d %H:%M:%S")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make the parent directories for this file if they don't already exist
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
