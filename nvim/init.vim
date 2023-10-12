" Set augroup
augroup MyAutoCmd
	autocmd!
augroup END

lua << EOF
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

EOF

" for colorscheme settings
colorscheme edge
highlight DduPreview guifg=#d6deeb guibg=#38507a
highlight DduCursor guibg=#38507a

" for non lazy hook
call dein#call_hook('source')

" user settings
" tab setting
set tabstop=4
set shiftwidth=4
set softtabstop=4
" list setting(制御文字の表示)
set list
set listchars=tab:>-
" plugin
set signcolumn=yes
set number
" mapping
inoremap <Left> <C-G>U<Left>
inoremap <Right> <C-G>U<Right>
imap <C-f> <Right>
imap <C-b> <Left>
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" emacs like cmdline keybind
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-Left> <S-Left>
cnoremap <C-Right> <S-Right>

" terminal
" tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
" filetype
let g:tex_flavor = 'latex'
" clipborad for windows
set clipboard&
if has('wsl')
	let g:clipboard = {
				\ 'name': 'win32yank',
				\ 'copy': {
				\   '+': 'win32yank.exe -i',
				\   '*': 'win32yank.exe -i',
				\ },
				\ 'paste': {
				\   '+': 'win32yank.exe -o',
				\   '*': 'win32yank.exe -o',
				\ },
				\ 'cache_enabled': 0
				\ }
endif
