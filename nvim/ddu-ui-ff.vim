" ddu-ff {{{

setlocal cursorline
setlocal signcolumn=yes
nnoremap <buffer><silent> <CR>
			\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
nnoremap <buffer><silent> t
			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabnew'}})<CR>
nnoremap <buffer><silent> o
			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
nnoremap <buffer><silent> v
			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
nnoremap <buffer><silent> <C-j>
			\ <Cmd>call ddu#ui#ff#do_action('kensaku')<CR>
nnoremap <buffer><silent> a
			\ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
nnoremap <buffer><silent> s
			\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
nnoremap <buffer><silent> i
			\ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
nnoremap <buffer><silent> c
			\ <Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>
nnoremap <buffer><silent> p
			\ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
nnoremap <buffer><silent> e
			\ <Cmd>call ddu#ui#ff#do_action('expandItem', {'mode': 'toggle'})<CR>
nnoremap <buffer><expr> -
			\ ddu#ui#get_item()->get('__sourceName') == 'file' ?
			\	"<ESC><Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow' , 'params': { 'path': '..' }})<CR>" :
			\	""
nnoremap <buffer><silent> q
			\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
autocmd CursorMoved <buffer> call s:update_cursor()
function! s:update_cursor()
	call sign_unplace('', #{ id: 100 })
	call sign_define('cursor', #{ text: '>>', texthl: 'Constant' })
	call sign_place(100, '', 'cursor', '%'->bufnr(), #{ lnum: '.'->line() })
endfunction

" }}}

" ddu-ff-filter {{{

nnoremap <buffer> <CR>
			\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
nnoremap <buffer><silent> q
			\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
inoremap <buffer> <C-p>
			\ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
inoremap <buffer> <C-e>
			\ <Cmd>call ddu#ui#ff#do_action('echoPath')<CR>
inoremap <buffer><expr> <CR>
			\ ddu#ui#get_item()->get('__sourceName') == 'file' ?
			\	ddu#ui#get_item()->get('action')->get('isDirectory') ?
			\		"<ESC><Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow' })<CR>" :
			\		"<ESC><Cmd>call ddu#ui#do_action('itemAction')<CR>" :
			\	"<ESC><Cmd>call ddu#ui#do_action('itemAction')<CR>"
inoremap <buffer> <C-t>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabnew'}})<CR>
inoremap <buffer> <C-o>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
inoremap <buffer> <C-v>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
inoremap <buffer> <C-n>
			\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
inoremap <buffer> <C-p>
			\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
inoremap <buffer> <C-s>
			\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
inoremap <buffer> <C-a>
			\ <Cmd>call ddu#ui#ff#do_action('toggleAllItems')<CR>
inoremap <buffer> <C-l>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('leaveFilterWindow')<CR>
inoremap <buffer> <C-j>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('kensaku')<CR>
inoremap <buffer> <C-q>
			\ <ESC><Cmd>call ddu#ui#ff#do_action('quit')<CR>

" }}}
