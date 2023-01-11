" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
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
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:ddu_toml = s:rc_dir . '/ddu.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'
  " let s:nyao_toml = s:rc_dir . '/dein_nyao.toml'

  " read toml and cache
  call dein#load_toml(s:toml)
  call dein#load_toml(s:ddu_toml, #{ lazy: 1})
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

" ddc settings
" json
let s:ddc_config_json =<< trim MARK
	{
		"ui": "native",
		"sources": ["around", "nvim-lsp", "vsnip", "skkeleton"],
		"sourceOptions": {
			"around": {
				"mark": "A"
			},
			"nvim-lsp": {
				"mark": "lsp",
				"dup": "force",
				"forceCompletionPattern": "\\.|->|::",
				"matchers": ["matcher_fuzzy"]
			},
			"vsnip": {
				"mark": "vsnip",
				"dup": "keep"
			},
			"skkeleton": {
				"mark": "skkeleton",
				"matchers": ["skkeleton"],
				"sorters": []
			},
			"_": {
				"matchers": ["matcher_head"],
				"sorters": ["sorter_rank"]
			}
		}
	}
MARK
let s:ddc_config_json = s:ddc_config_json->join('')->json_decode()
call ddc#custom#patch_global(s:ddc_config_json)
call ddc#enable()

" user settings
" plugin
set signcolumn=yes
" 補完におけるpreviewの非表示
set completeopt-=preview
" terminal
" tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
" filetype
let g:tex_flavor = 'latex'
" clipborad for windows
set clipboard&
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

" lua settings
luafile ~/dotfiles/nvim/plugin_settings.lua

" lua plugin
luafile ~/dotfiles/nvim/test.lua

