-- lua_source {{{

print("ddu.luaだよ")
vim.fn["ddu#custom#patch_global"]({
	ui = "ff",
	uiOptions = {
		filer = {
			toggle = true
		}
	},
	uiParams = {
		ff = {
			prompt = "> ",
			filterSplitDirection = "floating",
			split = "floating",
			floatingBorder = "rounded",
			floatingTitlePos = "center",
			previewFloating = true,
			previewFloatingBorder = "rounded",
			previewFloatingTitle = { { "Preview", "String" } },
			previewFloatingTitlePos = "center",
			highlights = {
				floatingCursorLine = "DduCursor",
				preview = "DduPreview"
			},
			previewWindowOptions = { { "&signcolumn", "no" }, { "&wrap", 0 }, { "&number", 0 }, { "&foldenable", 0 } }
		},
		filer = {
			split = "floating",
			floatingBorder = "rounded",
			previewFloating = true,
			previewFloatingBorder = "rounded",
			sortTreesFirst = true
		}
	},
	filterParams = {
		matcher_fzf = {
			highlightMatched = "String"
		},
		matcher_substring = {
			highlightMatched = "String"
		},
		matcher_kensaku = {
			highlightMatched = "String"
		}
	},
	kindOptions = {
		action = {
			defaultAction = "do",
			quit = "true"
		},
		file = {
			defaultAction = "open"
		},
		floaterm = {
			defaultAction = "open"
		},
		lsp = {
			defaultAction = "open"
		},
		ui_select = {
			defaultAction = "select"
		},
		command_history = {
			defaultAction = "execute"
		},
		help = {
			defaultAction = "open"
		},
		dein_update = {
			defaultAction = "viewDiff"
		},
		channel = {
			defaultAction = "open"
		},
		["ai-review-request"] = {
			defaultAction = "open"
		},
		["ai-review-log"] = {
			defaultAction = "resume"
		},
		window = {
			defaultAction = "open"
		},
		tab = {
			defaultAction = "open"
		}
	},
	actionOptions = {
		echo = {
			quit = false
		},
		echoDiff = {
			quit = false
		}
	},
	sourceOptions = {
		rg = {
			matchers = { "converter_display_word", "matcher_fzf" }
		},
		file_rec = {
			matchers = { "matcher_fzf" },
			converters = { "converter_file_icon" }
		},
		file_external = {
			matchers = { "matcher_fzf" },
			converters = { "converter_file_icon" }
		},
		channel = {
			columns = { "filename" }
		},
		dummy = {
			matchers = {}
		},
		dein_update = {
			matchers = { "matcher_dein_update" }
		},
		_ = {
			matchers = { "matcher_fzf" }
		}
	}
})

-- layout
WinCol = 1
WinRow = 1
WinWidth = vim.api.nvim_get_option("columns")
WinHeight = vim.api.nvim_get_option("lines")
Columns = vim.api.nvim_get_option("columns")
Lines = vim.api.nvim_get_option("lines")

local function set_size()
	-- 関数外部のwinColを参照して、columns / 8を代入する
	WinCol = math.floor(Columns / 8)
	WinRow = math.floor(Lines / 8)
	WinWidth = math.floor(Columns - (Columns / 4))
	WinHeight = math.floor(Lines - (Lines / 4))
end

local function set_ff_layout()
	-- ┌────────────────────────────────┐
	-- │                                │
	-- │                                │
	-- │        source                  │
	-- │                                │
	-- │                                │
	-- │                                │
	-- └────────────────────────────────┘
	vim.fn["ddu#custom#patch_local"]('default', {
		uiParams = {
			ff = {
				winCol = WinCol,
				winRow = WinRow,
				winWidth = WinWidth,
				winHeight = WinHeight
			}
		}
	})

	-- ┌────────────────┐┌────────────────┐
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- │  source        ││                │
	-- │                ││                │
	-- │                ││   preview      │
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- └────────────────┘│                │
	-- ┌────────────────┐│                │
	-- │   filter       ││                │
	-- └────────────────┘└────────────────┘
	vim.fn["ddu#custom#patch_local"]('ui_filter_preview_layout', {
		uiParams = {
			ff = {
				startFilter = true,
				filterFloatingPosition = 'bottom',
				autoAction = { name = 'preview' },
				startAutoAction = true,
				winCol = WinCol,
				winRow = WinRow,
				winWidth = math.floor(WinWidth / 2),
				winHeight = WinHeight,
				previewCol = WinCol + math.floor(WinWidth / 2) + 2,
				previewRow = WinRow + WinHeight + 5,
				previewWidth = math.floor(WinWidth / 2),
				previewHeight = WinHeight + 3,
			}
		}
	})

	-- ┌────────────────┐
	-- │                │
	-- │   preview      │
	-- │                │
	-- └────────────────┘
	-- ┌────────────────┐
	-- │   source       │
	-- │                │
	-- └────────────────┘
	-- ┌────────────────┐
	-- │   filter       │
	-- └────────────────┘
	vim.fn["ddu#custom#patch_local"]('ui_filter_preview_horizontal_layout', {
		uiParams = {
			ff = {
				startFilter = true,
				filterFloatingPosition = 'bottom',
				autoAction = { name = 'preview' },
				startAutoAction = true,
				previewSplit = 'horizontal',
				winCol = WinCol,
				winRow = math.floor(Lines / 2),
				winWidth = WinWidth,
				winHeight = math.floor(WinHeight / 2),
				previewCol = WinCol,
				previewRow = 0,
				previewWidth = WinWidth,
				previewHeight = math.floor(WinHeight / 2),
			}
		}
	})

	-- ┌────────────────┐
	-- │                │
	-- │   source       │
	-- │                │
	-- └────────────────┘
	-- ┌────────────────┐
	-- │   filter       │
	-- └────────────────┘
	vim.fn["ddu#custom#patch_local"]('ui_filter_layout', {
		uiParams = {
			ff = {
				startFilter = true,
				filterFloatingPosition = 'bottom',
				winCol = WinCol,
				winWidth = WinWidth,
				winRow = WinRow,
				winHeight = WinHeight,
			}
		}
	})

	-- ┌────────────────┐┌────────────────┐
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- │  source        ││   preview      │
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- └────────────────┘└────────────────┘
	vim.fn["ddu#custom#patch_local"]('ui_preview_layout', {
		uiParams = {
			ff = {
				autoAction = { name = 'preview' },
				startAutoAction = true,
				previewSplit = 'vertical',
				winCol = WinCol,
				winWidth = math.floor(WinWidth / 2),
				winRow = WinRow,
				winHeight = WinHeight,
				previewCol = WinCol + math.floor(WinWidth / 2) + 2,
				previewWidth = math.floor(WinWidth / 2),
				previewRow = WinRow,
				previewHeight = WinHeight,
			}
		}
	})
end

local function set_filer_layout()
	-- ┌────────────────────────────────┐
	-- │                                │
	-- │                                │
	-- │        source                  │
	-- │                                │
	-- │                                │
	-- │                                │
	-- └────────────────────────────────┘
	vim.fn["ddu#custom#patch_local"]('default', {
		uiParams = {
			filer = {
				winCol = WinCol,
				winRow = WinRow,
				winWidth = WinWidth,
				winHeight = WinHeight,
			}
		}
	})

	-- ┌────────────────┐┌────────────────┐
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- │  source        ││   preview      │
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- │                ││                │
	-- └────────────────┘└────────────────┘
	vim.fn["ddu#custom#patch_local"]('ui_filer_preview_layout', {
		uiParams = {
			filer = {
				autoAction = { name = 'preview' },
				startAutoAction = true,
				previewSplit = 'vertical',
				winCol = WinCol,
				winWidth = math.floor(WinWidth / 2),
				winRow = WinRow,
				winHeight = WinHeight,
				previewCol = WinCol + math.floor(WinWidth / 2) + 2,
				previewWidth = math.floor(WinWidth / 2),
				previewRow = WinRow,
				previewHeight = WinHeight,
			}
		}
	})
end

local function layout()
	set_size()
	set_ff_layout()
	set_filer_layout()
end

layout()

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
		layout()
	end
})

-- custom action

vim.fn["ddu#custom#action"]('kind', 'file', 'setcdo', function(args)
	local qflist = {}
	for _, item in ipairs(args["items"]) do
		local qf = {}
		qf["text"] = item["word"]
		local action = item["action"]
		qf["lnum"] = action["lineNr"]
		qf["bufnr"] = action["bufNr"]
		table.insert(qflist, qf)
	end
	vim.fn.setqflist(qflist, ' ')
	local cmd = vim.fn.input(":cdo ", "normal ")
	print(cmd)
	vim.fn.execute("cdo " .. cmd)
	return 0
end)

vim.fn["ddu#custom#action"]('source', 'file', 'file_rec', function(args)
	local items = args["items"]
	local action = items[1]["action"]
	vim.fn["ddu#start"]({
		sources = {
			{ name = "file_rec", options = { path = action["path"] } }
		}
	})
	return 0
end)

vim.fn["ddu#custom#action"]('kind', 'lsp', 'setBreakPoint', function(args)
	for _, item in ipairs(args["items"]) do
		local action = item["action"]
		local lnum = action["lnum"]
		vim.fn.execute(lnum)
		require("dap").set_breakpoint()
	end
	return 0
end)

vim.fn["ddu#custom#action"]('source', 'buffer', 'delete', function(args)
	for _, item in ipairs(args["items"]) do
		local action = item["action"]
		local bufNr = action["bufNr"]
		vim.fn.execute("bdelete " .. bufNr)
	end
	return 0
end)

vim.fn["ddu#custom#action"]('source', 'register', 'trimCRLF', function(args)
	for _, item in ipairs(args["items"]) do
		local regName = item["word"][0]
		local action = item["action"]
		-- local regType = action["regType"]
		local regText = action["text"]
		vim.fn.setreg(regName, vim.fn.substitute(regText, "\r", "", "g"))
	end
	return 1
end)

vim.fn["ddu#custom#action"]('ui', 'ff', 'kensaku', function(args)
	local sources = args["options"]["sources"]
	for _, source in ipairs(sources) do
		source["options"] = {
			matchers = { "matcher_kensaku" }
		}
	end
	vim.fn["ddu#ui#ff#do_action"]('updateOptions', {
		uiParams = {
			ff = {
				filterFloatingTitle = { { "日本語検索", "LightBlue" } },
				filterFloatingTitlePos = "center",
			}
		},
		sources = sources
	})
	return 2
end)

-- ddu key mapping

vim.keymap.set('n', '[ddu]', '<Nop>')
vim.keymap.set('n', '<Space>u', '[ddu]', { remap = true })

-- telescopeのREADMEの順っぽく設定

-- file周り
vim.keymap.set('n', '[ddu]f', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Filter", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "file_rec", params = {} }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]g', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Files", "FloatBorder" }, { "Git", "FloatBorder" } },
			}
		},
		sources = {
			{
				name = "file_external",
				params = { cmd = { "git", "ls-files" } }
			}
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]r', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				ignoreEmpty = false,
				autoResize = false,
				floatingTitle = { { "Live Grep", "String" } }
			}
		},
		sources = {
			{
				name = "rg",
				options = { matchers = {}, volatile = true }
			}
		}
	})
end, { remap = true })

-- vim周り
vim.keymap.set('n', '[ddu]b', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Buffers", "Blue" } },
			}
		},
		sources = {
			{ name = "buffer" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]c', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Command History", "FloatBorder" } },
				autoAction = {}
			}
		},
		sources = {
			{ name = "command_history" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]h', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Help", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "help" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]q', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "QuickFix", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "qf", params = { isSubset = true, format = "%p|%t" } }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]j', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_horizontal_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "JumpList", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "jumplist" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]t', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Tab", "FloatBorder" } },
				autoAction = {
					name = "preview",
					params = { border = { "+", "-", "+", "|" } }
				}
			}
		},
		sources = {
			{ name = "tab", params = { format = "tab|%n|%T:%w" } }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]w', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Window", "FloatBorder" } },
				autoAction = {
					name = "preview",
				}
			}
		},
		sources = {
			{
				name = "window",
				options = { matchers = { "matcher_regex", "matcher_fzf" } },
				params = { format = "tab:%tn:%T:%w:%wi" }
			}
		},
		filterParams = {
			matcher_regex = {
				regex = "^(?!.*ddu-ff).*$"
			}
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]L', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_horizontal_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Line", "FloatBorder" } },
				previewWindowOptions = { { "&signcolumn", "no" }, { "&wrap", 0 }, { "&number", 0 }, { "&relativenumber", 1 } }
			}
		},
		sources = {
			{ name = "line" }
		}
	})
end, { remap = true })

-- lsp
vim.keymap.set('n', '[ddu]lr', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Lsp References", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "lsp_references" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]ld', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Lsp Definition", "FloatBorder" } },
			}
		},
		sources = {
			{
				name = "dummy",
				options = {
					converters = {
						{ name = "converter_highlight", params = { hl_group = "Red" } }
					}
				},
				params = { display = ">>Definition<<" }
			},
			{ name = "lsp_definition", params = { method = "textDocument/definition" } },
			{
				name = "dummy",
				options = {
					converters = {
						{ name = "converter_highlight", params = { hl_group = "Blue" } }
					}
				},
				params = { display = ">>typeDefinition<<" }
			},
			{ name = "lsp_definition", params = { method = "textDocument/typeDefinition" } },
			{
				name = "dummy",
				options = {
					converters = {
						{ name = "converter_highlight", params = { hl_group = "Yellow" } }
					}
				},
				params = { display = ">>declaration<<" }
			},
			{ name = "lsp_definition", params = { method = "textDocument/declaration" } },
			{
				name = "dummy",
				options = {
					converters = {
						{ name = "converter_highlight", params = { hl_group = "Green" } }
					}
				},
				params = { display = ">>Implementation<<" }
			},
			{ name = "lsp_definition", params = { method = "textDocument/implementation" } },
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]ls', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Lsp Symbol", "FloatBorder" } },
			}
		},
		sources = {
			{ name = "dummy", params = { display = "documentSymbol" } },
			{ name = "lsp_documentSymbol" },
			{ name = "dummy", params = { display = "workspaceSymbol" } },
			{ name = "lsp_workspaceSymbol" },
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]lh', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Lsp Hierarchy", "FloatBorder" } },
				displayTree = true,
				startFilter = false
			}
		},
		sources = {
			{ name = "dummy", params = { display = "incomingCalls" } },
			{ name = "lsp_callHierarchy", params = { method = "callHierarchy/incomingCalls" } },
			{ name = "dummy", params = { display = "outgoingCalls" } },
			{ name = "lsp_callHierarchy", params = { method = "callHierarchy/outgoingCalls" } },
		}
	})
end, { remap = true })

-- 他プラグインとの連携
vim.keymap.set('n', '[ddu]T', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_horizontal_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Floaterm", "FloatBorder" } },
				startFilter = false,
			}
		},
		sources = {
			{ name = "floaterm" },
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]d', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_layout",
		uiParams = {
			ff = {
				floatingTitle = { { "Dein", "Black" } },
				autoAction = {}
			}
		},
		sources = {
			{ name = "dein" },
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]v<CR>', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		sources = {
			{ name = "channel_rec" },
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]ve<CR>', function()
	vim.fn["ddu#start"]({
		ui = "filer",
		sources = {
			{ name = "channel_rec", params = { type = "unread" } },
			{ name = "channel" },
		},
		sourceOptions = {
			channel = { path = "VtraQ" },
			channel_rec = { path = "unread" }
		}
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]vu<CR>', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		name = "ui_filter_preview_layout",
		sources = {
			{ name = "channel_rec", params = { type = "unread" } },
		}
	})
end, { remap = true })

-- filer
vim.keymap.set('n', '[ddu]e', function()
	vim.fn["ddu#start"]({
		ui = "filer",
		uiParams = {
			filer = {
				split = "floating",
				splitDirection = "topleft",
				previewFloating = true
			}
		},
		name = "ui_filer_preview_layout",
		resume = true,
		sources = { { name = "file" } },
		sourceOptions = { _ = { columns = { "icon_filename" } } },
	})
end, { remap = true })
vim.keymap.set('n', '[ddu]E', function()
	vim.fn["ddu#start"]({
		ui = "ff",
		uiParams = {
			ff = {
				startFilter = true,
				floatingTitle = { { "File", "FloatBorder" }, { "Browser", "Directory" } },
			}
		},
		sources = {
			{
				name = "file",
				options = {
					columns = { "icon_filename" },
					converters = { "converter_file_info" }
				}
			}
		},
	})
end, { remap = true })

-- }}}
