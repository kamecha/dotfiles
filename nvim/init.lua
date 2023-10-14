-- Install dir
local dein_dir = vim.fn.expand('~/.cache/dein/nvim')
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'
local github_dir = dein_dir .. '/repos/github.com'
vim.api.nvim_set_var('github_dir', github_dir)

-- In windows, auto_recache is not disabled. It is too slow.
if vim.fn.exists('g:dein#auto_recache') ~= 1 then
  vim.api.nvim_set_var('dein#auto_recache', vim.fn.has('win32') ~= 1)
end

-- dein installation check
if not vim.fn.glob(dein_repo_dir) == '' then
	vim.fn.system('git clone https://github.com/Shougo/dein.vim ' .. dein_repo_dir)
end

local function check_table(T, V)
	local ret = false
	for _, v in ipairs(T) do
		if v == V then
			ret = true
		end
	end
	return ret
end

if not check_table(vim.fn.split(vim.o.runtimepath, ','), dein_repo_dir) then
	vim.o.runtimepath = dein_repo_dir .. ',' .. vim.o.runtimepath
end

-- use dein
local dein = require('dein')

-- register plugin via dein
if dein.load_state(dein_dir) == 1 then
	dein.begin(dein_dir)
	local rc_dir = vim.fn.expand('~/.config/nvim')
	local toml = rc_dir .. '/dein.toml'
	local ddu_toml = rc_dir .. '/ddu.toml'
	local ddc_toml = rc_dir .. '/ddc.toml'
	dein.load_toml(toml)
	dein.load_toml(ddu_toml, { lazy = true })
	dein.load_toml(ddc_toml, { lazy = true })
	dein.end_()
	dein.save_state()
end

-- plugin installation check
if dein.check_install() then
  dein.install()
end

-- plugin remove check
local removed_plugins = dein.check_clean()
if #removed_plugins > 0 then
	for _, plugin in ipairs(removed_plugins) do
		vim.fn.delete(plugin, 'rf')
	end
	dein.recache_runtimepath()
end

-- for color setting
vim.cmd.colorscheme("edge")
vim.cmd.highlight({ "DduPreview", "guifg=#d6deeb", "guibg=#38507a" })
vim.cmd.highlight({ "DduCursor", "guibg=#38507a" })

-- for non lazy hook
dein.call_hook('source')

-- for options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.list = true
vim.opt.listchars = { tab = '>-' }
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'

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
