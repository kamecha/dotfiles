" hook_source {{{
luafile ~/.config/nvim/ddu.lua

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
