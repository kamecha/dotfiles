#!/bin/sh
set -e

cd ~

# OSごとに異なる設定
case $(uname) in
	"Linux" ) echo "Linux"
		if [ ! -f /usr/local/bin/starship ]
			then
				echo "Installing Starship..."
				curl -sS https://starship.rs/install.sh | sh
			else
				echo "Starship already installed."
		fi
		break;;
	"Darwin" ) echo "Mac"
		echo "architectures: $(uname -m) によってbrewのインストール方法が異なるので保留"
		# if [ ! -f /usr/local/bin/brew ]
		# 	then
		# 		echo "Installing Homebrew..."
		# 		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		# 	else
		# 		echo "Homebrew already installed."
		# fi
		break;;
esac

# echo "シンボリックリンクを貼る"
echo "Symlinking dotfiles..."
cd dotfiles

# for each editor
ln -sfv "$(pwd)/nvim" "$HOME/.config/"
ln -sfv "$(pwd)/.vimrc" "$HOME/.vimrc"
ln -sfv "$(pwd)/.vim" "$HOME/"
# for each shell
ln -sfv "$(pwd)/.bashrc" "$HOME/.bashrc"
ln -sfv "$(pwd)/.zshrc" "$HOME/.zshrc"
# for tmux
ln -sfv "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
ln -sfv "$(pwd)/.tmux" "$HOME/"
# check tmux is already installed
if [ ! -f /usr/local/bin/tmux ]
	then
		echo "tmux is not installed."
	else
		echo "tmux already installed."
		echo "source tmux.conf"
		tmux source ~/.tmux.conf
fi
