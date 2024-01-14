-- Install lazy
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazy_path,
	})
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- I have a separate config.mappings file where I require which-key.
	-- With lazy the plugin will be automatically loaded when it is required somewhere
	{ "folke/which-key.nvim",        lazy = true },

	{
		"nvim-neorg/neorg",
		-- lazy-load on filetype
		ft = "norg",
		-- options for neorg. This will automatically call `require("neorg").setup(opts)`
		opts = {
			load = {
				["core.defaults"] = {},
			},
		},
	},

	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-e>'] = cmp.mapping.abort(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
				})
			})
		end,
	},

	-- if some code requires a module from an unloaded plugin, it will be automatically loaded.
	-- So for api plugins like devicons, we can always set lazy=true
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- you can use the VeryLazy event for things that can
	-- load later and are not important for the initial UI
	{ "stevearc/dressing.nvim",      event = "VeryLazy" },

	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	{
		"monaqa/dial.nvim",
		-- lazy-load on keys
		-- mode is `n` by default. For more advanced options, check the section on key mappings
		keys = { "<C-a>", { "<C-x>", mode = "n" } },
	},

	-- local plugins can also be configure with the dev option.
	-- This will use {config.dev.path}/noice.nvim/ instead of fetching it from Github
	-- With the dev option, you can easily switch between the local and installed version of a plugin
	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true
				},
				popupmenu = {
					enabled = true,
					backend = "cmp"
				}
			})
		end
	},
	{
		"vim-denops/denops.vim"
	},
	{
		"kamecha/denops-dbus_synctex",
		dependencies = { "vim-denops/denops.vim" },
		config = function()
			local syncTex = require("dbus_synctex")
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "tex",
				callback = function()
					vim.keymap.set("n", "<Leader>s", syncTex.syncViewCWD, { buffer = true })
				end
			})
			vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "DenopsPluginPost:dbus_synctex",
			callback = function()
				syncTex.createSessionBus()
				syncTex.registerCallback(function (_, line, col, _)
					vim.fn.cursor({ line, col < 0 and 1 or col })
				end)
				syncTex.registerSyncSource(syncTex.getPdfPathCWD())
			end
		})
		end
	}
})
