
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
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

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

" ddc settings
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['around', 'vim-lsp', 'skkeleton'])
call ddc#custom#patch_global('sourceOptions', {
		\ 'around': {
		\	'mark': 'A',
		\},
		\ 'vim-lsp': {
		\ 	'mark': 'lsp',
		\ 	'dup': 'force',
		\ 	'forceCompletionPattern': '\.\w*',
		\},
		\ 'skkeleton': {
		\ 	'mark': 'skkeleton',
		\	'matchers': ['skkeleton'],
		\	'sorters': [],
		\	'minAutoCompleteLength': 2,
		\},
		\ '_': {
		\	'matchers': ['matcher_head'],
		\	'sorters': ['sorter_rank'],
		\},
		\ })
call ddc#enable()

" ddu settings
" set the default ui.
call ddu#custom#patch_global({
		\ 'ui': 'ff',
		\ 'uiParams': {
		\	'ff': {
		\		'startFilter': v:true,
		\       	'prompt': '> ',
		\       	'autoAction': {'name': 'preview'},
		\       	'previewVertical': v:true,
		\       	'previewFloating': v:true,
		\ 	},
		\ }
		\})
" set the default action
call ddu#custom#patch_global({
		\ 'kindOptions': {
		\	'file': {
		\		'defaultAction': 'open',
		\	},
		\ }
		\})
" Specify matcher
call ddu#custom#patch_global({
		\ 'sourceOptions': {
		\	'_': {
		\		'matchers': ['matcher_substring'],
		\	},
		\ }
		\})
" set default sources
call ddu#custom#patch_global({
		\ 'sources' : [{'name': 'file_rec', 'params': {}}],
		\ })

" ddu keybind
autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
	nnoremap <buffer><silent> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	nnoremap <buffer><silent> <Space>
				\ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
	nnoremap <buffer><silent> i
				\ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
	nnoremap <buffer><silent> p
				\ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
	nnoremap <buffer><silent> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
	nnoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	nnoremap <buffer><silent> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
	inoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	inoremap <buffer> <C-t>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabnew'}})<CR>
	inoremap <buffer> <C-s>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
	inoremap <buffer> <C-v>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
	inoremap <buffer> <C-j>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
	inoremap <buffer> <C-k>
				\ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
endfunction

nmap <silent> ;f <Cmd>call ddu#start({})<CR>

" user settings
" terminal
tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
