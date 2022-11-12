# 色を使用
autoload -Uz colors
colors
# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# コマンドミスを修正
setopt correct
# プロンプト
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%d%{$reset_color%} [%D]
$"
# git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'
# alias
alias gitlog='git log --graph --all'
alias iCloud_dir='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias ls='ls -G'
alias la='ls -a'

# PATH
export PATH=$PATH:/usr/local/bin
export PATH=/usr/local/bin/git:$PATH

. /opt/homebrew/opt/asdf/libexec/asdf.sh
