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
	vim.keymap.set('n', 'gn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup_handlers({ function(server_name)
	local opts = {
		on_attach = on_attach,
	}
	nvim_lsp[server_name].setup(opts)
end })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- language serverごとにcapabilitiesを追加する必要があります。
-- -- on_attachは必要に応じて
-- require'lspconfig'.clangd.setup{on_attach = on_attach, capabilities = capabilities}

require('fidget').setup({})

vim.notify = require('notify')

-- settting for null-ls to use textlint
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.textlint.with({
			filetypes = { "markdown" },
			command = "textlint",
		})
	},
})

-- settting for nocie.vim
-- require('noice').setup {
-- 	cmdline = {
-- 		format = {
-- 			cmdline = { icon = ">" },
-- 			search_down = { icon = "🔍⌄" },
-- 			search_up = { icon = "🔍⌃" },
-- 			filter = { icon = "$" },
-- 			lua = { icon = "☾" },
-- 			help = { icon = "?" },
-- 		},
-- 	},
-- 	popupmenu = {
-- 		enabled = true,
-- 		view = "nui",
-- 	},
-- }

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
