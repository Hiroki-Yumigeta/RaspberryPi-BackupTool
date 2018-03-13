#!/bin/sh
# coding:utf-8

# コピー関数
Copyfunc(){
    if [ -e $2 ]; then # file found, or not
        echo "$2 copying..."
        cp -r $2 $1/ # copy files
    else
        echo "$2 not found"
    fi
}

# アーカイブファイル出力先
out_dir=$(dirname $(readlink -f $0))

# tempディレクトリ作成
tmp_dir=$(mktemp -d)

# サブディレクトリ追加
mkdir -p $tmp_dir/usr $tmp_dir/glb

# temp dirに移動
cd $tmp_dir

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
echo

# rc.local
echo -n "copy rc.local. (Y/n)"
read flag
case $flag in
    "Y" | "y")
        Copyfunc glb /etc/rc.local
    ;;
esac
echo

# vim
echo -n "copy vim. (Y/n)"
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
echo

# アーカイブファイル作成
filename=$(date "+%Y%m%d_%H%M%S").tar.gz # ファイル名

echo "create archive file"
echo "$tmp_dir -> $filename"
echo -n "(press any key)"
read ""
# アーカイブ
tar -czf $filename ./*

# 移動
mv $filename $out_dir

# tmp 削除
rm -rf $tmp_dir

# 解凍
#cd $out_dir
#tar -xzf $filename

# finish
echo
echo 'Done'
