#!/bin/sh
#coding:utf-8

# copy function
Copyfunc(){
    if [ -e $2 ]; then # file found, or not
        echo "$2 copying..."
        cp -r $2 $1/ # copy files
    else
        echo "$2 not found"
    fi
}

# 保存先
dir=$(date "+%Y%m%d_%H%M%S")
mkdir -p $dir/usr $dir/glb
cd $dir

# bashrc
echo -n "copy config on bash. (Y/n)"
read flag
case $flag in
    "Y" | "y")
        Copyfunc usr $HOME/.bashrc
        Copyfunc usr $HOME/.bash_aliases
        Copyfunc usr $HOME/.bash_profile
        Copyfunc glb /etc/bashrc
        Copyfunc glb /etc/profile
    ;;
esac

# rc.local
echo -n "copy rc.local. (Y/n)"
read flag
case $flag in
    "Y" | "y")
        Copyfunc glb /etc/rc.local
    ;;
esac

# vim
echo "copy vim. (Y/n)"
read flag
case $flag in
    "Y" | "y")
        Copyfunc usr $HOME/.vim/
        Copyfunc usr $HOME/.vimrc
        Copyfunc usr $HOME/_vimrc
        Copyfunc usr $HOME/.gvimrc
        Copyfunc glb /etc/vimrc
        Copyfunc glb /etc/gvimrc
    ;;
esac
cd ../
# finish
echo "Done"
