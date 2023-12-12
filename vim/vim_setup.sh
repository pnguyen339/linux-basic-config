#/bin/bash
linux=false
if [[ "$(uname)" == "Darwin" ]]; then
    echo "This is macOS"
    linux=false
elif [[ "$(uname)" == "Linux" ]]; then
    echo "This is Linux"
    linux=true
else
    echo "This is not macOS or Linux"
    exit
fi

installVimBundle() {
    local dir=$1
    local git=$2
    if [ -d "$dir" ]; then
        echo "$dir exist"
    else
        git clone $git $dir
    fi

    git config --global --add safe.directory $dir
}

#Vundle Installation
installVimBundle "$HOME/.vim/bundle/Vundle.vim" "https://github.com/VundleVim/Vundle.vim.git"

#Colorscheme
installVimBundle "$HOME/.vim/bundle/vim-colors-solarized" "https://github.com/altercation/vim-colors-solarized.git"

#YouCompleteMe Installation
if $linux; then
    sudo apt install build-essential cmake python3-dev python-is-python3
else 
    brew install java cmake python go nodejs
fi

installVimBundle "$HOME/.vim/bundle/YouCompleteMe" "https://github.com/ycm-core/YouCompleteMe.git"
python3 $HOME/.vim/bundle/YouCompleteMe/install.py

#syntastic Installation
installVimBundle "$HOME/.vim/bundle/syntastic" "https://github.com/vim-syntastic/syntastic.git"


sudo cp ./vimrc  $HOME/.vimrc
vim +PluginInstall +qall