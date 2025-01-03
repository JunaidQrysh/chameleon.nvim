local M = {}
local options = {

	base46 = {
		hl_add = {},
		hl_override = {},
		integrations = {},
		changed_themes = {},
		transparency = false,
	},

	ui = {
		cmp = {
			icons_left = false, -- only for non-atom styles!
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
			format_colors = {
				tailwind = false, -- will work for css lsp too
				icon = "󱓻",
			},
		},

		telescope = { style = "bordered" }, -- borderless / bordered

		statusline = {
			enabled = false,
			theme = "default", -- default/vscode/vscode_colored/minimal
			-- default/round/block/arrow separators work only for default statusline theme
			-- round and block will work for minimal theme only
			separator_style = "default",
			order = nil,
			modules = nil,
		},
	},
}

M = vim.tbl_deep_extend("force", options, require("chameleon").opts or {})

return M
