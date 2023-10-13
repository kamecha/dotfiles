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
	local lazy_toml = rc_dir .. '/dein_lazy.toml'
	dein.load_toml(toml)
	dein.load_toml(ddu_toml, { lazy = true })
	dein.load_toml(ddc_toml, { lazy = true })
	dein.load_toml(lazy_toml, { lazy = true })
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

