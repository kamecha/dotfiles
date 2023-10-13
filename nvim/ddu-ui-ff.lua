-- ddu-ff {{{

vim.opt_local.cursorline = true
vim.opt_local.signcolumn = 'yes'

vim.keymap.set('n', '<CR>', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction')
end, { buffer = true })
vim.keymap.set('n', 't', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "tabnew" } })
end, { buffer = true })
vim.keymap.set('n', 'o', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "split" } })
end, { buffer = true })
vim.keymap.set('n', 'v', function()
	vim.fn["ddu#ui#ff#do_action"]('itemAction', { params = { command = "vsplit" } })
end, { buffer = true })
vim.keymap.set('n', '<C-j>', function()
	vim.fn["ddu#ui#ff#do_action"]('kensaku')
end, { buffer = true })
vim.keymap.set('n', 'a', function()
	vim.fn["ddu#ui#ff#do_action"]('chooseAction')
end, { buffer = true })
vim.keymap.set('n', 's', function()
	vim.fn["ddu#ui#ff#do_action"]('toggleSelectItem')
end, { buffer = true })
vim.keymap.set('n', 'i', function()
	vim.fn["ddu#ui#ff#do_action"]('openFilterWindow')
end, { buffer = true })
vim.keymap.set('n', 'c', function()
	vim.fn["ddu#ui#ff#do_action"]('closeFilterWindow')
end, { buffer = true })
vim.keymap.set('n', 'p', function()
	vim.fn["ddu#ui#ff#do_action"]('preview')
end, { buffer = true })
vim.keymap.set('n', 'e', function()
	vim.fn["ddu#ui#ff#do_action"]('expandItem', { mode = "toggle" })
end, { buffer = true })
vim.keymap.set('n', 'q', function()
	vim.fn["ddu#ui#ff#do_action"]('quit')
end, { buffer = true })
vim.keymap.set('n', '-', function()
	local sourceName = vim.fn["ddu#ui#get_item"]()["__sourceName"]
	if sourceName == "file" then
		vim.fn["ddu#ui#ff#do_action"]('itemAction', {
			name = "narrow",
			params = { path = ".." }
		})
	end
end, { buffer = true })

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	buffer = 0,
	callback = function()
		vim.fn.sign_unplace('', { id = 100 })
		vim.fn.sign_define("cursor", { text = ">>", texthl = "Constant" })
		vim.fn.sign_place(100, '', "cursor", vim.fn.bufnr('%'), { lnum = vim.fn.line('.') })
	end
})

-- }}}
