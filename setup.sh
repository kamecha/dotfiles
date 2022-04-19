#!/bin/sh
set -e

cd ~

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
		".swp" ) ;;
		".config" ) ;;
		".vim" ) ;;
		*)
		ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
	esac
done