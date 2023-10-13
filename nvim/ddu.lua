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
