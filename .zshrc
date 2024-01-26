# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# コマンドミスを修正
setopt correct
# alias
alias gitlog='git log --graph --all'
alias iCloud_dir='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias ls='ls -G'
alias la='ls -a'

# starship
eval "$(starship init zsh)"

# PATH
export PATH=$PATH:/usr/local/bin
export PATH=/usr/local/bin/git:$PATH

. /usr/local/opt/asdf/libexec/asdf.sh
