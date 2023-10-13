" ddu-filer {{{

nnoremap <buffer><expr> <CR>
			\ ddu#ui#get_item()->get('isTree', v:false) ?
			\ "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>" :
			\ "<Cmd>call ddu#ui#do_action('itemAction')<CR>"
nnoremap <buffer><silent> e
			\ <Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>
nnoremap <buffer><silent> p
			\ <Cmd>call ddu#ui#do_action('togglePreview')<CR>
nnoremap <buffer><silent> s
			\ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
nnoremap <buffer><silent> o
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'split'}})<CR>
nnoremap <buffer><silent> v
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
nnoremap <buffer><silent> t
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>
nnoremap <buffer><silent> a
			\ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
nnoremap <buffer><silent> %
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>
nnoremap <buffer><silent> d
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>
nnoremap <buffer><silent> R
			\ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>
nnoremap <buffer><silent> q
			\ <Cmd>call ddu#ui#do_action('quit')<CR>

" }}}
