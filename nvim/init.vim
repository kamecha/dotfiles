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
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()

  " Required:
  filetype plugin indent on
  syntax enable
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

" for colorscheme settings
colorscheme edge

" ddc settings
" json
let s:ddc_config_json =<< trim MARK
	{
		"ui": "native",
		"sources": ["around", "vim-lsp", "vsnip", "skkeleton"],
		"sourceOptions": {
			"around": {
				"mark": "A"
			},
			"vim-lsp": {
				"mark": "lsp",
				"dup": "force",
				"forceCompletionPattern": "\\.|->|::",
				"matchers": ["matcher_fuzzy"]
			},
			"vsnip": {
				"mark": "vsnip",
				"dup": "keep"
			},
			"skkeleton": {
				"mark": "skkeleton",
				"matchers": ["skkeleton"],
				"sorters": [],
				"minAutoCompleteLength": 2
			},
			"_": {
				"matchers": ["matcher_head"],
				"sorters": ["sorter_rank"]
			}
		}
	}
MARK
let s:ddc_config_json = s:ddc_config_json->join('')->json_decode()
call ddc#custom#patch_global(s:ddc_config_json)
call ddc#enable()

" ddu settings

" json
let s:ddu_config_json =<< trim MARK
	{
		"uiOptions": {
			"filer": {
				"toggle": true
			}
		},
		"uiParams": {
			"ff": {
				"highlights": {},
				"startFilter": true,
				"prompt": "> ",
				"autoAction" : { "name": "preview" },
				"previewVertical": true
			},
			"filer": {
				"split": "vertical",
				"splitDirection": "topleft",
				"sortTreesFirst": true
			}
		},
		"filterParams": {
			"matcher_substring": {
				"highlightMatched": "DduMatch"
			}
		},
		"kindOptions": {
			"file": {
				"defaultAction": "open"
			}
		},
		"sourceOptions": {
			"_": {
				"matchers": ["matcher_substring"]
			}
		},
		"sources" : [{"name": "file", "params": {}}]
	}
MARK

let s:ddu_config_json = s:ddu_config_json->join('')->json_decode()

let g:vimrc#ddu_highlights = "NormalFloat:DduFloat,CursorLine:DduCursorLine,EndOfBuffer:DduEnd,Search:DduMatch"
let s:ddu_config_json['uiParams']['ff']['floatingBorder'] = ['.', '.', '.', ':', ':', '.', ':', ':']->map('[v:val, "DduBorder"]')
let s:ddu_config_json['uiParams']['ff']['split'] = has('nvim') ? 'floating' : 'horizontal'
let s:ddu_config_json['uiParams']['ff']['previewFloating'] = has('nvim')
let s:ddu_config_json['uiParams']['ff']['previewFloatingBorder'] = ['.', '.', '.', ':', ':', '.', ':', ':']->map('[v:val, "DduBorder"]')

function! s:set_size() abort
	let winCol = &columns / 8
	let winWidth = &columns - (&columns / 4)
	let winRow = &lines / 8
	let winHeight = &lines - (&lines / 4)
	let s:ddu_config_json['uiParams']['ff']['winCol'] = winCol
	let s:ddu_config_json['uiParams']['ff']['winWidth'] = winWidth
	let s:ddu_config_json['uiParams']['ff']['winRow'] = winRow
	let s:ddu_config_json['uiParams']['ff']['winHeight'] = winHeight
	" 参考url:https://github.com/kuuote/dotvim/blob/master/conf/plug/ddu.vim#L85
	" fzf-previewやtelescopeみたいなpreviewの出し方をする
	" - winWidthの部分が内部コードに依存してるのでアレ
	" (previewVerticalの時、絶対位置にwinWidthを足して出しているのでその分を引き去る)
	" よってpreviewVertical = trueじゃないと動かない
	let s:ddu_config_json['uiParams']['ff']['previewCol'] = winCol + (winWidth / 2) - winWidth
	let s:ddu_config_json['uiParams']['ff']['previewWidth'] = winWidth / 2
	let s:ddu_config_json['uiParams']['ff']['previewRow'] = winRow
	let s:ddu_config_json['uiParams']['ff']['previewHeight'] = winHeight
endfunction

function s:color_scheme()
	" if &background ==# 'light'
		hi DduEnd guibg=#e0e0ff guifg=#e0e0ff
		hi DduFloat guibg=#e0e0ff guifg=#6060ff
		hi DduBorder guibg=#f0f0ff guifg=#6060ff
		hi DduMatch ctermfg=205 ctermbg=225 guifg=#ff60c0 guibg=#ffd0ff cterm=NONE gui=NONE
		hi DduCursorLine ctermfg=205 ctermbg=225 guifg=#ff6060 guibg=#ffe8e8 cterm=NONE gui=NONE
		let g:vimrc#ddu_highlights = "NormalFloat:DduFloat,CursorLine:DduCursorLine,EndOfBuffer:DduEnd,Search:DduMatch"
	" else
		" let g:vimrc#ddu_highlights = 'NormalFloat:Normal,DduBorder:Normal,DduMatch:Search'
	" endif
	let s:ddu_config_json['uiParams']['ff']['highlights']['floating'] = g:vimrc#ddu_highlights
endfunction

function! s:reset() abort
	call s:set_size()
	call s:color_scheme()
	call ddu#custom#patch_global(s:ddu_config_json)
endfunction

call s:reset()
autocmd ColorScheme,VimResized * call s:reset()

" ddu keybind
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
	nnoremap <buffer><silent> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	nnoremap <buffer><silent> <Space>
				\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
	nnoremap <buffer><silent> i
				\ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
	nnoremap <buffer><silent> p
				\ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
	nnoremap <buffer><silent> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
	nnoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	nnoremap <buffer><silent> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
	inoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	inoremap <buffer> <C-q>
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
	inoremap <buffer> <C-t>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabnew'}})<CR>
	inoremap <buffer> <C-s>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
	inoremap <buffer> <C-v>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
	inoremap <buffer> <C-j>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
	inoremap <buffer> <C-k>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
	nnoremap <buffer><expr> <CR>
				\ ddu#ui#filer#is_tree() ?
				\ "<Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>" :
				\ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"
	nnoremap <buffer><silent> <Space>
				\ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
	nnoremap <buffer><silent> q
				\ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction

nmap <silent> ;f <Cmd>call ddu#start({'ui': 'ff', 'sources': [{'name': 'file_rec', 'params': {}}]})<CR>
nmap <silent> ;e <Cmd>call ddu#start({'ui': 'filer', 'uiParams': {'filer': {'winWidth': &columns / 6}}})<CR>

" user settings
" plugin
set signcolumn=yes
" terminal
" tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
" filetype
let g:tex_flavor = 'latex'
" clipborad for windows
set clipboard&
