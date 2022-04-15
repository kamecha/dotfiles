" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}


" ddc. settings
call ddc#custom#patch_global('sources', ['around', 'vim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']
	  \ },
	  \ })
call ddc#enable()

" status line settings
" 0: never 1: only split 2: always
set laststatus=2

" indent settings
" keep current indent
set autoindent
" auto indent for C like
set smartindent

" tab settings
" tab width is 4 times spaces
set tabstop=4
" vim auto make tab to 4
set shiftwidth=4
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
