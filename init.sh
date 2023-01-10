mkdir -p ~/.config/nvim
ln -s ~/.vim/vimrcs/vimrc.vim ~/.config/nvim/init.vim
git submodule update --init --recursive
PIP_USER='yes' PIP_REQUIRE_VIRTUALENV="" /usr/bin/python3 -m pip install flake8
