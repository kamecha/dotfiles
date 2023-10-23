-- vim.cmd.luafile(vim.fn.expand(vim.fn.stdpath("config") .. "/lazy.lua"))

vim.cmd.luafile(vim.fn.expand(vim.fn.stdpath("config") .. "/dein.lua"))

-- for color setting
vim.cmd.colorscheme("edge")
vim.cmd.highlight({ "DduPreview", "guifg=#d6deeb", "guibg=#38507a" })
vim.cmd.highlight({ "DduCursor", "guibg=#38507a" })
vim.cmd.highlight({ "JpSpace", "guibg=#404455" })

-- for options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.list = true
vim.opt.listchars = { tab = '>-', eol = '↲', trail = '_', nbsp = '␣' }
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = "*",
	callback = function()
		vim.cmd.match("JpSpace", "/　/")
	end
})

-- keymap
vim.keymap.set('i', '<Left>', '<C-G>U<Left>')
vim.keymap.set('i', '<Right>', '<C-G>U<Right>')
vim.keymap.set('i', '<C-f>', '<Right>', { remap = true })
vim.keymap.set('i', '<C-b>', '<Left>', { remap = true })
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-Left>', '<S-Left>')
vim.keymap.set('c', '<C-Right>', '<S-Right>')

-- auto commands
vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })

-- for each environment
-- for wsl2
if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'win32yank',
		copy = {
			['+'] = 'win32yank.exe -i --crlf',
			['*'] = 'win32yank.exe -i --crlf',
		},
		paste = {
			['+'] = 'win32yank.exe -o --lf',
			['*'] = 'win32yank.exe -o --lf',
		},
		cache_enabled = 0,
	}
end
