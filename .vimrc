"行番号を表示
set number
"行番号相対表示
set relativenumber
"タイトル表示
set title
"シンタックスハイライト
syntax enable
"ステータスライン
set laststatus=2
"タブ文字helpを参照
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
"改行時に前の行のインデントを継続する
set autoindent
"インデントを意識して改行
set smartindent
"検索の際、大文字ありでsensitive
set ignorecase smartcase
"検索パターンのハイライト
set hlsearch
"インクリメンタルサーチ
set incsearch
"カーソルの位置表示
set cursorline

"補完
"括弧の補完
inoremap {<Enter> {}<left><CR><C-c>==<S-o>
inoremap (( ()<left>
inoremap {{ {}<left>
inoremap [[ []<left>
inoremap '' ''<left>
inoremap "" ""<left>
"空行挿入
noremap <Space><CR> o<ESC>
"ハイライト消去
nnoremap <F3> :noh<CR>

"swapFileを作成しない
set noswapfile
