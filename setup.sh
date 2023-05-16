#!/bin/sh
set -e

cd ~

# tmux関連の設定を行う関数を定義
tmux_setup() {
	# tmuxのインストール
	if [ ! -f /usr/local/bin/tmux ]
	then
		# echo "Installing tmux..."
		# sudo apt install -y tmux
		echo "tmux is not installed."
		return
	else
		echo "tmux already installed."
	fi
	# tmuxのプラグインマネージャ、tpmをインストール
	if [ ! -d ~/.tmux/plugins/tpm ]
	then
		echo "Installing TPM..."
		git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
	else
		echo "TPM already installed."
	fi
	# .tmux.confをシンボリックリンクで貼る
	ln -sfv "$(cd ~/dotfiles; pwd)/.tmux.conf" "$HOME/.tmux.conf"
	# check tmux is already installed
	if [ ! -f /usr/local/bin/tmux ]
	then
		echo "tmux is not installed."
	else
		echo "tmux already installed."
		echo "source tmux.conf"
		tmux source ~/.tmux.conf
		echo "user prefix + I to install plugins"
	fi
}

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
		# tmuxのプラグインマネージャ、tpmをインストール
		tmux_setup
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
ln -sfv "$(pwd)/starship.toml" "$HOME/.config/starship.toml"
