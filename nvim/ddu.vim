" hook_source {{{
let s:ddu_config_json =<< trim MARK
	{
		"ui": "ff",
		"uiOptions": {
			"filer": {
				"toggle": true
			}
		},
		"uiParams": {
			"ff": {
				"prompt": "> ",
				"filterSplitDirection": "floating",
				"split": "floating",
				"floatingBorder": "rounded",
				"floatingTitlePos": "center",
				"previewFloating":true,
				"previewFloatingBorder": "rounded",
				"previewFloatingTitle": [ ["Preview", "String"] ],
				"previewFloatingTitlePos": "center",
				"highlights": {
					"floatingCursorLine": "DduCursor",
					"preview": "DduPreview"
				},
				"previewWindowOptions": [ ["&signcolumn", "no"], ["&wrap", 0], ["&number", 0], ["&foldenable", 0] ]
			},
			"filer": {
				"split": "floating",
				"floatingBorder": "rounded",
				"previewFloating":true,
				"previewFloatingBorder": "rounded",
				"sortTreesFirst": true
			}
		},
		"filterParams": {
			"matcher_fzf": {
				"highlightMatched": "String"
			},
			"matcher_substring": {
				"highlightMatched": "String"
			},
			"matcher_kensaku": {
				"highlightMatched": "String"
			}
		},
		"kindOptions": {
			"action": {
				"defaultAction": "do",
				"quit": "true"
			},
			"file": {
				"defaultAction": "open"
			},
			"floaterm": {
				"defaultAction": "open"
			},
			"lsp": {
				"defaultAction": "open"
			},
			"ui_select": {
				"defaultAction": "select"
			},
			"command_history": {
				"defaultAction": "execute"
			},
			"help": {
				"defaultAction": "open"
			},
			"dein_update": {
				"defaultAction": "viewDiff"
			},
			"channel": {
				"defaultAction": "open"
			},
			"ai-review-request": {
				"defaultAction": "open"
			},
			"ai-review-log": {
				"defaultAction": "resume"
			},
			"window": {
				"defaultAction": "open"
			},
			"tab": {
				"defaultAction": "open"
			}
		},
		"actionOptions": {
			"echo": {
				"quit": false
			},
			"echoDiff": {
				"quit": false
			}
		},
		"sourceOptions": {
			"rg": {
				"matchers": ["converter_display_word", "matcher_fzf"]
			},
			"file_rec": {
				"matchers": ["matcher_fzf"],
				"converters": ["converter_file_icon"]
			},
			"file_external": {
				"matchers": ["matcher_fzf"],
				"converters": ["converter_file_icon"]
			},
			"channel": {
				"columns": ["filename"]
			},
			"dummy": {
				"matchers": []
			},
			"dein_update": {
				"matchers": ["matcher_dein_update"]
			},
			"_": {
				"matchers": ["matcher_fzf"]
			}
		}
	}
MARK

let s:ddu_config_json = s:ddu_config_json->join('')->json_decode()

call ddu#custom#patch_global(s:ddu_config_json)

" jsonだと式が書けないので、レイアウト周りはここで設定する

let s:winCol = 1
let s:winWidth = &columns
let s:winRow = 1
let s:winHeight = &lines

function! s:set_size() abort
	" window自体は左上が始点となる
	let s:winCol = &columns / 8
	let s:winWidth = &columns - (&columns / 4)
	let s:winRow = &lines / 8
	let s:winHeight = &lines - (&lines / 4)
endfunction

function! s:set_ff_layout() abort
	" ┌────────────────────────────────┐
	" │                                │
	" │                                │
	" │        source                  │
	" │                                │
	" │                                │
	" │                                │
	" └────────────────────────────────┘
	call ddu#custom#patch_local('default', {
				\ 'uiParams': {
				\	'ff': {
				\		'winCol': s:winCol,
				\		'winRow': s:winRow,
				\		'winWidth': s:winWidth,
				\		'winHeight': s:winHeight,
				\	}
				\}
				\})

	" ┌────────────────┐┌────────────────┐
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" │  source        ││                │
	" │                ││                │
	" │                ││   preview      │
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" └────────────────┘│                │
	" ┌────────────────┐│                │
	" │   filter       ││                │
	" └────────────────┘└────────────────┘
	call ddu#custom#patch_local('ui_filter_preview_layout', {
				\ 'uiParams': {
				\	'ff': {
				\		'startFilter': v:true,
				\		'filterFloatingPosition': 'bottom',
				\		'autoAction': { 'name': 'preview' },
				\		'startAutoAction': v:true,
				\		'winCol': s:winCol,
				\		'winRow': s:winRow,
				\		'winWidth': s:winWidth / 2,
				\		'winHeight': s:winHeight,
				\		'previewCol': s:winCol + s:winWidth / 2 + 2,
				\		'previewRow': s:winRow + s:winHeight + 5,
				\		'previewWidth': s:winWidth / 2,
				\		'previewHeight': s:winHeight + 3,
				\	}
				\}
				\})

	" ┌────────────────┐
	" │                │
	" │   preview      │
	" │                │
	" └────────────────┘
	" ┌────────────────┐
	" │   source       │
	" │                │
	" └────────────────┘
	" ┌────────────────┐
	" │   filter       │
	" └────────────────┘
	call ddu#custom#patch_local('ui_filter_preview_horizontal_layout', {
				\ 'uiParams': {
				\	'ff': {
				\		'startFilter': v:true,
				\		'filterFloatingPosition': 'bottom',
				\		'autoAction': { 'name': 'preview' },
				\		'startAutoAction': v:true,
				\		'previewSplit': 'horizontal',
				\		'winCol': s:winCol,
				\		'winRow': &lines / 2,
				\		'winWidth': s:winWidth,
				\		'winHeight': s:winHeight / 2,
				\		'previewCol': s:winCol,
				\		'previewRow': 0,
				\		'previewWidth': s:winWidth,
				\		'previewHeight': s:winHeight / 2,
				\	}
				\}
				\})

	" ┌────────────────┐
	" │                │
	" │   source       │
	" │                │
	" └────────────────┘
	" ┌────────────────┐
	" │   filter       │
	" └────────────────┘
	call ddu#custom#patch_local('ui_filter_layout', {
				\ 'uiParams': {
				\	'ff': {
				\		'startFilter': v:true,
				\		'filterFloatingPosition': 'bottom',
				\		'winCol' : s:winCol,
				\		'winWidth' : s:winWidth,
				\		'winRow' : s:winRow,
				\		'winHeight' : s:winHeight,
				\	}
				\}
				\})

	" ┌────────────────┐┌────────────────┐
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" │  source        ││   preview      │
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" └────────────────┘└────────────────┘
	call ddu#custom#patch_local('ui_preview_layout', {
				\ 'uiParams': {
				\	'ff': {
				\		'autoAction': { 'name': 'preview' },
				\		'startAutoAction': v:true,
				\		'previewSplit': 'vertical',
				\		'winCol' : s:winCol,
				\		'winWidth' : s:winWidth / 2,
				\		'winRow' : s:winRow,
				\		'winHeight' : s:winHeight,
				\		'previewCol' : s:winCol + s:winWidth / 2 + 2,
				\		'previewWidth' : s:winWidth / 2,
				\		'previewRow' : s:winRow,
				\		'previewHeight' : s:winHeight,
				\	}
				\}
				\})
endfunction

function! s:set_filer_layout() abort
	" ┌────────────────────────────────┐
	" │                                │
	" │                                │
	" │        source                  │
	" │                                │
	" │                                │
	" │                                │
	" └────────────────────────────────┘
	call ddu#custom#patch_local('default', {
				\ 'uiParams': {
				\	'filer': {
				\		'winCol': s:winCol,
				\		'winRow': s:winRow,
				\		'winWidth': s:winWidth,
				\		'winHeight': s:winHeight,
				\	}
				\}
				\})

	" ┌────────────────┐┌────────────────┐
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" │  source        ││   preview      │
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" │                ││                │
	" └────────────────┘└────────────────┘
	call ddu#custom#patch_local('ui_filer_preview_layout', {
				\ 'uiParams': {
				\	'filer': {
				\		'autoAction': { 'name': 'preview' },
				\		'startAutoAction': v:true,
				\		'previewSplit': 'vertical',
				\		'winCol' : s:winCol,
				\		'winWidth' : s:winWidth / 2,
				\		'winRow' : s:winRow,
				\		'winHeight' : s:winHeight,
				\		'previewCol' : s:winCol + s:winWidth / 2 + 2,
				\		'previewWidth' : s:winWidth / 2,
				\		'previewRow' : s:winRow,
				\		'previewHeight' : s:winHeight,
				\	}
				\}
				\})
endfunction
function! s:layout() abort
	call s:set_size()
	call s:set_ff_layout()
	call s:set_filer_layout()
endfunction

call s:layout()

autocmd VimResized * call s:layout()

function s:setcdo(args)
	let items = a:args->get('items')
	let qflist = []
	for item in items
		let qf = {}
		let qf['text'] = item->get('word')
		let action = item->get('action')
		let qf['lnum'] = action->get('lineNr')
		let qf['bufnr'] = action->get('bufNr')
		let qflist = add(qflist, qf)
	endfor
	call setqflist(qflist, ' ')
	let cmd = input(":cdo ", "normal ")
	echo cmd
	execute 'cdo ' . cmd
	return 0
endfunction

call ddu#custom#action('kind', 'file', 'setcdo', function('s:setcdo'))

function s:file_rec(args)
	let items = a:args->get('items')
	let action = items[0]->get('action')
	call ddu#start(#{
				\ sources: [#{ name: 'file_rec', options: #{ path: action->get('path') } }]
				\ })
	return 0
endfunction

call ddu#custom#action('source', 'file', 'file_rec', function('s:file_rec'))

function s:setBreakPoint(args)
	let items = a:args->get('items')
	for item in items
		let action = item->get('action')
		let lnum = action->get('lnum')
		let bufNr = action->get('bufNr')
		" goto selected line
		call execute(lnum)
		" set breakpoint at the line
		lua require('dap').set_breakpoint()
	endfor
	return 0
endfunction

call ddu#custom#action('source', 'lsp_documentSymbol', 'setBreakPoint', function('s:setBreakPoint'))

function s:deleteBuffer(args)
	let items = a:args->get('items')
	for item in items
		let action = item->get('action')
		let bufNr = action->get('bufNr')
		execute 'bdelete ' . bufNr
	endfor
	return 0
endfunction

call ddu#custom#action('source', 'buffer', 'delete', function('s:deleteBuffer'))

" windowsからコピペする際に\r(表記上^M)が無駄に入ってくるやつの対処
function s:trimCRLF(args)
	let items = a:args->get('items')
	for item in items
		let regName = item->get('word')[0]
		let action = item->get('action')
		" :h getregtype()
		let regType = action->get('regType')
		let regText = action->get('text')
		call setreg(regName, regText->substitute('\r', '', 'g'))
	endfor
	return 1
endfunction

call ddu#custom#action('source', 'register', 'trimCRLF', function('s:trimCRLF'))

function s:echoPath(args)
	let context = a:args->get('context')
	echomsg context->get('path')
	return 0
endfunction

call ddu#custom#action('ui', 'ff', 'echoPath', function('s:echoPath'))

function s:update_source_to_kensaku(key, val)
	let a:val['options'] = #{ matchers: ["matcher_kensaku"] }
	return a:val
endfunction

function s:kensaku_filter(args)
	let kensaku_sources = copy(a:args)->get('options')->get('sources')->map(function('s:update_source_to_kensaku'))
	call ddu#ui#ff#do_action('updateOptions', #{ 
				\	uiParams: #{
				\		ff: #{
				\			filterFloatingTitle: [['日本語検索', 'LightBlue']],
				\			filterFloatingTitlePos: 'center',
				\		}
				\	},
				\	sources: kensaku_sources
				\	})
	return 2 "Redraw
endfunction

call ddu#custom#action('ui', 'ff', 'kensaku', function('s:kensaku_filter'))

nnoremap [ddu] <Nop>
nmap <Space>u [ddu]

" telescopeのREADMEの順っぽく設定していく
" File
nmap <silent> [ddu]f <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Files', 'FloatBorder']],
			\		}
			\ },
			\ 'sources': [{'name': 'file_rec', 'params': {}}]
			\ })<CR>
nmap <silent> [ddu]g <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Files', 'FloatBorder'], ['Git', 'FloatBorder']],
			\		}
			\ },
			\ 'sources': [{
			\	'name': 'file_external',
			\	'params': { 'cmd': ['git', 'ls-files'] }
			\ }]
			\ })<CR>
" live grep
nmap <silent> [ddu]r <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'ignoreEmpty': v:false,
			\			'autoResize': v:false,
			\			'floatingTitle': [['Live Grep', 'String']],
			\		}
			\ },
			\ 'sources': [
			\	{
			\		'name': 'rg',
			\ 		'options': {'matchers': [], 'volatile': v:true},
			\	},
			\ ],
			\})<CR>

" Vim 関連
nmap <silent> [ddu]b <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Buffer', 'Blue']],
			\		}
			\ },
			\ 'sources': [{'name': 'buffer'}],
			\ 'sourceOptions': {
			\		'buffer': {
			\			'matchers': ['matcher_regex', 'matcher_fzf']
			\		}
			\ },
			\ 'filterParams': {
			\		'matcher_regex': {
			\			'regex': '^(?!.*\[No\s+Name\]$).*$'
			\		}
			\ }
			\ })<CR>
nmap <silent> [ddu]c <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Command History', 'FloatBorder']],
			\			'autoAction': {},
			\		}
			\ },
			\ 'sources': [{'name': 'command_history'}],
			\ })<CR>
nmap <silent> [ddu]h <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Help', 'FloatBorder']],
			\		}
			\ },
			\ 'sources': [{'name': 'help', 'params': {}}],
			\ })<CR>
" QuickFix
nmap <silent> [ddu]q <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'prompt': 'qf',
			\			'floatingTitle': [['QuickFix', 'String']],
			\		}
			\ },
			\ 'sources': [
			\	{
			\		'name': 'qf',
			\		'params': {
			\			'isSubset': v:true,
			\			'format': '%p\|%t',
			\ 		}
			\	},
			\ ],
			\})<CR>
nmap <silent> [ddu]j <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_horizontal_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['JumpList', 'String']],
			\		}
			\ },
			\ 'sources': [{'name': 'jumplist', 'params': {}}],
			\ })<CR>
nmap <silent> [ddu]t <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Tab', 'FloatBorder']],
			\			'autoAction': { 
			\				'name': 'preview',
			\				'params': { 'border': ['+', '-', '+', '\|'] }
			\			},
			\		}
			\ },
			\ 'sources': [{'name': 'tab', 'params': { 'format': 'tab\|%n:%T:%w' }}]
			\ })<CR>
nmap <silent> [ddu]w <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Window', 'FloatBorder']],
			\			'autoAction': { 
			\				'name': 'preview',
			\			},
			\		}
			\ },
			\ 'sources': [
			\		{
			\			'name': 'window',
			\			'options': { 'matchers': ['matcher_regex', 'matcher_fzf'] },
			\			'params': { 'format': 'tab:%tn:%T:%w:%wi' }
			\		}
			\ ],
			\ 'filterParams': {
			\		'matcher_regex': {
			\			'regex': '^(?!.*ddu-ff).*$'
			\		}
			\ }
			\ })<CR>
nmap <silent> [ddu]L <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_horizontal_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Line', 'String']],
			\			'previewWindowOptions': [ ['&signcolumn', 'no'], ['&wrap', 0], ['&number', 1], ['&relativenumber', 1] ]
			\		}
			\ },
			\ 'sources': [{'name': 'line', 'params': {}}],
			\ })<CR>

" Neovim LSP 関連
" lsp
nmap <silent> [ddu]lr <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\	'ff': {
			\		'floatingTitle': [['Lsp References', 'FloatBorder']],
			\	}
			\ },
			\ 'sources': [
			\	{'name': 'lsp_references'}
			\ ],
			\ })<CR>
nmap <silent> [ddu]ld <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\	'ff': {
			\		'floatingTitle': [['Lsp Definition', 'FloatBorder']],
			\	}
			\ },
			\ 'sources': [
			\	{
			\		'name': 'dummy',
			\		'options': { 
			\			'converters': [
			\				{ 
			\					'name': 'converter_highlight', 'params': { 'hl_group': 'Red' }
			\				}
			\			] 
			\		},
			\		'params': { 'display': '>>Definition<<' }
			\	},
			\	{'name': 'lsp_definition', 'params': { 'method': 'textDocument/definition' }},
			\	{
			\		'name': 'dummy',
			\		'options': {
			\			'converters': [
			\				{ 'name': 'converter_highlight', 'params': { 'hl_group': 'Blue' }}
			\			] 
			\		},
			\		'params': { 'display': '>>typeDefinition<<' }
			\	},
			\	{'name': 'lsp_definition', 'params': { 'method': 'textDocument/typeDefinition' }},
			\	{
			\		'name': 'dummy',
			\		'options': {
			\			'converters': [
			\				{ 'name': 'converter_highlight', 'params': { 'hl_group': 'Yellow' }}
			\			] 
			\		},
			\		'params': { 'display': '>>declaration<<' }
			\	},
			\	{'name': 'lsp_definition', 'params': { 'method': 'textDocument/declaration' }},
			\	{
			\		'name': 'dummy',
			\		'options': {
			\			'converters': [
			\				{ 'name': 'converter_highlight', 'params': { 'hl_group': 'Green' }}
			\			] 
			\		},
			\		'params': { 'display': '>>Implementation<<' }
			\	},
			\	{'name': 'lsp_definition', 'params': { 'method': 'textDocument/implementation' }},
			\ ],
			\ })<CR>
nmap <silent> [ddu]ls <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'uiParams': {
			\	'ff': {
			\		'floatingTitle': [['Lsp Symbol', 'FloatBorder']],
			\	}
			\ },
			\ 'sources': [
			\	{'name': 'dummy', 'params': { 'display': 'documentSymbol' }},
			\	{'name': 'lsp_documentSymbol'},
			\	{'name': 'dummy', 'params': { 'display': 'workspaceSymbol' }},
			\	{'name': 'lsp_workspaceSymbol'}
			\ ],
			\ })<CR>
nmap <silent> [ddu]lh <Cmd>call ddu#start({
			\ 'ui': 'filer',
			\ 'name': 'ui_filer_preview_layout',
			\ 'uiParams': {
			\	'ff': {
			\		'floatingTitle': [['Lsp Hierarchy', 'FloatBorder']],
			\		'displayTree': v:true,
			\		'startFilter': v:false,
			\		'previewSplit': 'vertical',
			\	}
			\ },
			\ 'sources': [
			\	{'name': 'dummy', 'params': { 'display': 'incomingCalls' }},
			\	{'name': 'lsp_callHierarchy', 'params': { 'method': 'callHierarchy/incomingCalls' }},
			\	{'name': 'dummy', 'params': { 'display': 'outgoingCalls' }},
			\	{'name': 'lsp_callHierarchy', 'params': { 'method': 'callHierarchy/outgoingCalls' }}
			\ ],
			\ })<CR>

" 他のプラグインとの連携
nmap <silent> [ddu]T <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_horizontal_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Floaterm', 'FloatBorder']],
			\		}
			\ },
			\ 'sources': [{'name': 'floaterm'}]
			\ })<CR>
nmap <silent> [ddu]d <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_layout',
			\ 'uiParams': {
			\		'ff': {
			\			'floatingTitle': [['Dein', 'Black']],
			\			'autoAction': {},
			\		}
			\ },
			\ 'sources': [{'name': 'dein'}],
			\ })<CR>
" VtraQ
nmap <silent> [ddu]v<CR> <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'sources': [{'name': 'channel_rec', 'params': {}}],
			\})<CR>
nmap <silent> [ddu]ve<CR> <Cmd>call ddu#start({
			\ 'ui': 'filer',
			\ 'sources': [
			\	{'name': 'channel_rec', 'params': {'type': 'unread'}},
			\	{'name': 'channel'}
			\ ],
			\ 'sourceOptions': {'channel': { 'path': 'VtraQ' }, 'channel_rec': {'path': 'unread'}},
			\})<CR>
nmap <silent> [ddu]vu<CR> <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'sources': [{'name': 'channel_rec', 'params': {'type': 'unread'}}],
			\})<CR>
nmap <silent> [ddu]vs<CR> <Cmd>call ddu#start({
			\ 'ui': 'ff',
			\ 'name': 'ui_filter_preview_layout',
			\ 'sources': [{'name': 'channel_rec', 'params': {'type': 'subscribed'}}],
			\})<CR>


" filer 表示
nmap <silent> [ddu]e <Cmd>call ddu#start({
			\ 'ui': 'filer',
			\ 'name': 'ui_filer_preview_layout',
			\ 'resume': v:true,
			\ 'sources': [{'name': 'file'}],
			\ 'sourceOptions': {'_': {'columns': ['icon_filename']}},
			\ 'uiParams': {
			\	'filer': {
			\		'split': 'floating',
			\		'splitDirectoin': 'topleft',
			\		'previewFloating': v:true,
			\	}
			\ },
			\ })<CR>
nmap <silent> [ddu]E <Cmd>call ddu#start({
			\ 'uiParams': { 
			\	'ff': { 
			\		'startFilter': v:true ,
			\		'floatingTitle': [['File', 'Normal'], ['Browser', 'Directory']],
			\	} 
			\ },
			\ 'sources': [
			\	{
			\		'name': 'file',
			\		'options': {
			\			'columns': ['icon_filename'],
			\			'converters': ['converter_file_info'],
			\		}
			\	}
			\ ],
			\ })<CR>

" }}}