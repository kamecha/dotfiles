
" OLED表示用のロゴ(A, B, ...)
" 0x7C, 0x12, 0x11, 0x12, 0x7C, 0x00
" 0x00, 0x7F, 0x49, 0x49, 0x49, 0x36,
" 0x00, 0x3E, 0x41, 0x41, 0x41, 0x22,
" 0x00, 0x7F, 0x41, 0x41, 0x41, 0x3E,
" 0x00, 0x7F, 0x49, 0x49, 0x49, 0x41,

" 0x02 → 0000 0010
function! s:hexToBin(hex) abort
	let l:hex = str2nr(a:hex, 16)
	let bin = ""
	for i in range(8)
		let bin = and(l:hex, 1) . bin
		let l:hex = l:hex >> 1
	endfor
	return bin
endfunction

" 0000 0010, 0000 0110 ...	→	00
" 								10
" 								01
" 								01
" 								00
" 								00
" 								00
" 								00 ...
function! s:binToOled(binList) abort
	let l:oled = []
	for i in range(8)
		let l:oled = add(l:oled, '')
	endfor
	for bin in a:binList
		for i in range(8)
			let l:oled[i] = l:oled[i] . ( bin[8-(i+1)] ? '■': '□' )
		endfor
	endfor
	return l:oled
endfunction

" 非空白文字のみを抽出
function! s:filterNonSpace(str) abort
	return substitute(a:str, '\s\+', '', 'g')
endfunction

" 16進数のみを抽出
function! s:filterHex(str) abort
	let ret = substitute(a:str, '^.*\(0x[0-9a-fA-F]\{2\}\).*$', '\1', '')
	return ret
endfunction

function! Echo() range abort
  let textList = getline(a:firstline, a:lastline)
  let startPos = getpos("'<")
  let endPos = getpos("'>")
  let tmpPos = { 'lnum': startPos[1], 'col': startPos[2] }
  let hexList = []
  for text in textList
	  " まずは普通のビジュアルモードに対応させる
	  " let splitText = strpart(text, startPos - 1, endPos - startPos + 1)
	  " 最終行
	  if tmpPos['lnum'] == endPos[1]
		  let splitText = strpart(text, tmpPos['col'] - 1, endPos[2] - tmpPos['col'] + 1)
	  else
		  let splitText = strpart(text, tmpPos['col'] - 1, len(text) - tmpPos['col'] + 1)
		  let tmpPos['lnum'] = str2nr(tmpPos['lnum']) + 1
		  let tmpPos['col'] = 1
	  endif
	  " let binText = s:hexToBin(splitText)
	  for separatedText in split(splitText, ',')
		  let hex = s:filterHex(s:filterNonSpace(separatedText))
		  let hexList = add(hexList, hex)
	  endfor
  endfor
  let binList = []
  for hex in hexList
	  let binList = add(binList, s:hexToBin(hex))
  endfor
  let oled = s:binToOled(binList)
  call popup_atcursor(oled, {'pos': 'botleft'})
endfunction
command! -range OLEDFromHexList :<line1>,<line2>call Echo()

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein/vim')
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

" }}}

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
" ファイルタイプに応じたインデント
filetype plugin indent on
"検索の際、大文字ありでsensitive
set ignorecase smartcase
"検索パターンのハイライト
set hlsearch
"インクリメンタルサーチ
set incsearch
"swapFileを作成しない
set noswapfile
"マウスを常に有効
set mouse=a
"クリップボードを共有
set clipboard&
set clipboard^=unnamedplus
"折り畳みの背景色を変更
highlight Folded ctermbg=Black
" 目印とかがなくても余白を開ける
set signcolumn=yes

"空行挿入
noremap <Space><CR> o<ESC>
"ハイライト消去
nnoremap <F3> :noh<CR>


colorscheme desert

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
