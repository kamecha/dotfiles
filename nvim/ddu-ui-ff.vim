" ddu-ff {{{

luafile ~/.config/nvim/ddu-ui-ff.lua

" setlocal cursorline
" setlocal signcolumn=yes
" nnoremap <buffer><silent> <CR>
" 			\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
" nnoremap <buffer><silent> t
" 			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabnew'}})<CR>
" nnoremap <buffer><silent> o
" 			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
" nnoremap <buffer><silent> v
" 			\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
" nnoremap <buffer><silent> <C-j>
" 			\ <Cmd>call ddu#ui#ff#do_action('kensaku')<CR>
" nnoremap <buffer><silent> a
" 			\ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
" nnoremap <buffer><silent> s
" 			\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
" nnoremap <buffer><silent> i
" 			\ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
" nnoremap <buffer><silent> c
" 			\ <Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>
" nnoremap <buffer><silent> p
" 			\ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
" nnoremap <buffer><silent> e
" 			\ <Cmd>call ddu#ui#ff#do_action('expandItem', {'mode': 'toggle'})<CR>
" nnoremap <buffer><expr> -
" 			\ ddu#ui#get_item()->get('__sourceName') == 'file' ?
" 			\	"<ESC><Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow' , 'params': { 'path': '..' }})<CR>" :
" 			\	""
" nnoremap <buffer><silent> q
" 			\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
" autocmd CursorMoved <buffer> call s:update_cursor()
" function! s:update_cursor()
" 	call sign_unplace('', #{ id: 100 })
" 	call sign_define('cursor', #{ text: '>>', texthl: 'Constant' })
" 	call sign_place(100, '', 'cursor', '%'->bufnr(), #{ lnum: '.'->line() })
" endfunction

" }}}

" ddu-ff-filter {{{

lua << EOF
vim.keymap.set('n', '<CR>', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction')
end, { buffer = true })
vim.keymap.set('n', 'q', function()
	vim.fn["ddu#ui#ff#do_action"]('quit')
end, { buffer = true })
vim.keymap.set('i', '<CR>', function()
	if vim.fn["ddu#ui#get_item"]()["__sourceName"] == "file" and vim.fn["ddu#ui#get_item"]()["action"]["isDirectory"] == true then
		vim.fn["ddu#ui#ff#do_action"]('itemAction', { name = "narrow" })
	else
		vim.fn["ddu#ui#ff#do_action"]('itemAction')
	end
end, { buffer = true })
vim.keymap.set('i', '<C-p>', function()
	vim.fn["ddu#ui#ff#do_action"]('preview')
end, { buffer = true })
vim.keymap.set('i', '<C-t>', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "tabnew" } })
end, { buffer = true })
vim.keymap.set('i', '<C-o>', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "split" } })
end, { buffer = true })
vim.keymap.set('i', '<C-v>', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "vsplit" } })
end, { buffer = true })
vim.keymap.set('i', '<C-n>', function()
	vim.fn["ddu#ui#ff#do_action"]("cursorNext")
end, { buffer = true })
vim.keymap.set('i', '<C-p>', function()
	vim.fn["ddu#ui#ff#do_action"]("cursorPrevious")
end, { buffer = true })
vim.keymap.set('i', '<C-s>', function()
	vim.fn["ddu#ui#ff#do_action"]("toggleSelectItem")
end, { buffer = true })
vim.keymap.set('i', '<C-a>', function()
	vim.fn["ddu#ui#ff#do_action"]("toggleAllItems")
end, { buffer = true })
vim.keymap.set('i', '<C-l>', function()
	vim.fn["ddu#ui#ff#do_action"]("leaveFilterWindow")
end, { buffer = true })
vim.keymap.set('i', '<C-j>', function()
	vim.fn["ddu#ui#ff#do_action"]("kensaku")
end, { buffer = true })
vim.keymap.set('i', '<C-q>', function()
	vim.fn["ddu#ui#ff#do_action"]("quit")
end, { buffer = true })

EOF

" }}}
