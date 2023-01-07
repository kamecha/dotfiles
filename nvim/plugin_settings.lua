-- LSP setting
require("mason").setup()
local nvim_lsp = require("lspconfig")

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local on_attach = function (client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup_handlers({ function(server_name)
	local opts = {
		on_attach = on_attach,
	}
	nvim_lsp[server_name].setup(opts)
end })

require('fidget').setup({})

-- Color Settings
-- require("nvim-treesitter").setup()
-- require'nvim-treesitter.configs'.setup {
-- 	highlight = {
-- 		enable = true,
-- 		disable = {
-- 			"ddu-ff",
-- 			"ddu-ff-filter"
-- 		}
-- 	}
-- }
--
