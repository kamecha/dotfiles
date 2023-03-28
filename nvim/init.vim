" Set augroup
augroup MyAutoCmd
	autocmd!
augroup END

" install dir {{{
let s:dein_dir = expand('~/.cache/dein/nvim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
" In windows, auto_recache is not disabled. It is too slow.
let g:dein#auto_recache = !has('win32')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:ddu_toml = s:rc_dir . '/ddu.toml'
  let s:ddc_toml = s:rc_dir . '/ddc.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'
  " let s:nyao_toml = s:rc_dir . '/dein_nyao.toml'

  " read toml and cache
  call dein#load_toml(s:toml)
  call dein#load_toml(s:ddu_toml, #{ lazy: 1})
  call dein#load_toml(s:ddc_toml, #{ lazy: 1})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " end settings
  call dein#end()
  call dein#save_state()

  " Required:
  filetype plugin indent on
  syntax enable
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

" }}}

" for colorscheme settings
colorscheme edge

" for non lazy hook
call dein#call_hook('source')

" enable plugin setting
call popup_preview#enable()
" 補完におけるpreviewの非表示
set completeopt-=preview

" user settings
" tab setting
set tabstop=4
set shiftwidth=4
set softtabstop=4
" plugin
set signcolumn=yes
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

" lua settings
luafile ~/dotfiles/nvim/plugin_settings.lua
