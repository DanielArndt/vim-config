""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close the current buffer
map <leader>bd :Bclose<cr>
" Close the buffer and window
map <leader>bq :Bclose<cr>:q<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" 0 goes to start of line respecting indents, aligns window for long lines
nmap 0 0^

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

" If there are mutiple tags, ask which one the user wants to jump to
nnoremap <C-]> g<C-]>

" Local replace
" nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" The above didn't work in Julia... but probably works in other languages.
nnoremap gr gd[[V][::s/<C-R>///gc<left><left><left>
" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" F-keys
function! ToggleBackground()
    if (&background =~ "light")
        exec "set background=dark"
    else
        exec "set background=light"
    endif
endfunction

set pastetoggle=<F2>

noremap <F3> :set wrap!<CR>
imap <F3> <C-o><F3>

noremap <F4> :set relativenumber!<CR>
" Refresh
map <F5> :e!<CR>:syntax sync fromstart<CR>
imap <F5> <C-o><F5>

map <F6> :call ToggleBackground()<CR>
imap <F6> <C-o><F6>

map <F8> :ALEFix<CR>
imap <F8> <C-o><F6>


"""""""""""""
" Leader keys
"""""""""""""

nmap <leader><leader> :silent ! .git/hooks/ctags<cr>
" Fast saving
nmap <leader>w :w!<cr>
" Fast quit
noremap <leader>q <C-w>q

" Disable highlight when <leader>/ is pressed
map <silent> <leader>/ :noh<cr>

" 'Follow' a tag in a second window pane on the right
nnoremap <leader>] <C-w>o<C-w><C-v>g<C-]>zt

" Inserts a newline and aligns the text
nnoremap <leader><CR> i<CR><Esc>==

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" todo list / scratch pad
map <leader>, :e! ~/Documents/scratch.rst<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext


" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
