" Set augroup
augroup MyAutoCmd
	autocmd!
augroup END

luafile ~/.config/nvim/unko.lua

" for colorscheme settings
" colorscheme edge
" highlight DduPreview guifg=#d6deeb guibg=#38507a
" highlight DduCursor guibg=#38507a

" for non lazy hook
" call dein#call_hook('source')

" user settings
" tab setting
" set tabstop=4
" set shiftwidth=4
" set softtabstop=4
" list setting(制御文字の表示)
" set list
" set listchars=tab:>-
" plugin
" set signcolumn=yes
" set number
" mapping
" inoremap <Left> <C-G>U<Left>
" inoremap <Right> <C-G>U<Right>
" imap <C-f> <Right>
" imap <C-b> <Left>
" nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" emacs like cmdline keybind
" cnoremap <C-A> <Home>
" cnoremap <C-E> <End>
" cnoremap <C-N> <Down>
" cnoremap <C-P> <Up>
" cnoremap <C-Left> <S-Left>
" cnoremap <C-Right> <S-Right>

" terminal
" tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | terminal <args>
autocmd TermOpen * startinsert
" filetype
let g:tex_flavor = 'latex'
" clipborad for windows
" set clipboard&
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
