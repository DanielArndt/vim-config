set runtimepath+=~/.vim
set packpath+=~/.vim

source ~/.vim/vimrcs/main.vim

try
    source ~/.vim/local/local_config.vim
catch
endtry
