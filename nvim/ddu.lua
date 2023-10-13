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
