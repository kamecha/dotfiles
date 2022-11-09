
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

" ddc settings
" json
let s:ddc_config_json =<< trim MARK
	{
		"ui": "native",
		"sources": ["around", "vim-lsp", "skkeleton"],
		"sourceOptions": {
			"around": {
				"mark": "A"
			},
			"vim-lsp": {
				"mark": "lsp",
				"dup": "force",
				"forceCompletionPattern": ".\\w*"
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
		"ui": "ff",
		"uiParams": {
			"ff": {
				"highlights": {
					"floating": "NormalFloat:DduFloat,CusrsorLine:DduCursorLine"
				},
				"startFilter": true,
				"prompt": "> ",
				"autoAction": {"name": "preview"},
				"previewVertical": true
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
		"sources" : [{"name": "file_rec", "params": {}}]
	}
MARK

let s:ddu_config_json = s:ddu_config_json->join('')->json_decode()

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

call s:set_size()
call ddu#custom#patch_global(s:ddu_config_json)

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

nmap <silent> ;f <Cmd>call ddu#start({})<CR>

autocmd ColorScheme * highlight DduFloat guibg=#e0e0ff guifg=#6060ff
autocmd ColorScheme * highlight DduBorder guibg=#f0f0ff guifg=#6060ff
autocmd ColorScheme * highlight DduMatch ctermfg=205 ctermbg=225 guifg=#ff60c0 guibg=#ffd0ff cterm=NONE gui=NONE
autocmd ColorScheme * highlight DduCursorLine ctermfg=205 ctermbg=225 guifg=#ff6060 guibg=#ffe8e8 cterm=NONE gui=NONE

" user settings
" terminal
" tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
