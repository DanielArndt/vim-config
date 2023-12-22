mkdir -p ~/.config/nvim
ln -s ~/.vim/vimrcs/vimrc.vim ~/.config/nvim/init.vim
git submodule update --init --recursive
