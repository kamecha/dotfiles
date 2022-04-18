#!/bin/sh
set -e

cd ~

# OSごとに異なる設定
case $(uname) in
	"Linux" ) echo "Linux";;
	"Darwin" ) echo "Mac"
		if [ ! -f /usr/local/bin/brew ]
			then
				echo "Installing Homebrew..."
				/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
			else
				echo "Homebrew already installed."
		fi
		break;;
esac

# echo "シンボリックリンクを貼る"
echo "Symlinking dotfiles..."
cd dotfiles
for dotfile in .??*; do
	case $dotfile in
		".git" ) ;;
		".gitignore" ) ;;
		".config" ) ;;
		".vim" ) ;;
		".bashrc" | ".zshrc" )
			echo "set for each shell"
			shell=$(echo $SHELL | rev | cut -d "/" -f 1 | rev)
			shellrc=".${shell}rc"
			ln -snfv "$(pwd)/${shellrc}" "$HOME/${shellrc}"
			;;
		*)
		ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
	esac
done
