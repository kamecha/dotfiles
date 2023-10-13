" ddu-filer {{{

lua << EOF
vim.keymap.set('n', '<CR>', function()
	local item = vim.fn["ddu#ui#get_item"]()
	if item["isTree"] ~= nil and item["isTree"] then
		vim.fn["ddu#ui#do_action"]('expandItem', { mode = 'toggle' })
	else
		vim.fn["ddu#ui#do_action"]('itemAction')
	end
end, { buffer = true })
vim.keymap.set('n', 'e', function()
	vim.fn["ddu#ui#do_action"]('expandItem', { mode = 'toggle' })
end, { buffer = true })
vim.keymap.set('n', 'p', function()
	vim.fn["ddu#ui#do_action"]('togglePreview')
end, { buffer = true })
vim.keymap.set('n', 's', function()
	vim.fn["ddu#ui#do_action"]('toggleSelectItem')
end, { buffer = true })
vim.keymap.set('n', 'o', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'open', params = { command = 'split' } })
end, { buffer = true })
vim.keymap.set('n', 'v', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'open', params = { command = 'vsplit' } })
end, { buffer = true })
vim.keymap.set('n', 't', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'open', params = { command = 'tabnew' } })
end, { buffer = true })
vim.keymap.set('n', 'a', function()
	vim.fn["ddu#ui#do_action"]('chooseAction')
end, { buffer = true })
vim.keymap.set('n', '%', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'newFile' })
end, { buffer = true })
vim.keymap.set('n', 'd', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'newDirectory' })
end, { buffer = true })
vim.keymap.set('n', 'R', function()
	vim.fn["ddu#ui#do_action"]('itemAction', { name = 'rename' })
end, { buffer = true })
vim.keymap.set('n', 'q', function()
	vim.fn["ddu#ui#do_action"]('quit')
end, { buffer = true })
EOF

" }}}
