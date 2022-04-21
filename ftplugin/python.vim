filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylsp']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['isort', 'black']

" Add the following to .lvimrc in the project root to enable auto-fix on save
" let g:ale_fix_on_save = 1
