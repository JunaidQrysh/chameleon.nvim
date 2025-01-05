local M = {}

local g = vim.g
local api = vim.api
local fn = vim.fn
local cache_path = g.base46_cache
local tbl_deep_extend = vim.tbl_deep_extend
local deepcopy = vim.deepcopy
local opts = require("chconf").base46
local neviline = "vim.opt.statusline = '%!v:lua.require(\"statusline.neviline\").run()'"

local stl = "vim.o.statusline = '%!v:lua.require(\"statusline.stl."
	.. require("chconf").ui.statusline.theme
	.. "\")()' "
	.. 'require("statusline.stl.utils").autocmds()'

local get_statusline = function(bool)
	vim.api.nvim_clear_autocmds({
		event = "LspProgress",
		pattern = { "begin", "end" },
	})
	if bool then
		vim.opt.statusline = '%!v:lua.require("statusline.neviline").run()'
	else
		vim.o.statusline = "%!v:lua.require('statusline.stl." .. require("chconf").ui.statusline.theme .. "')()"
		require("statusline.stl.utils").autocmds()
	end
end

local BASE_INTEGRATIONS = {
	"blankline",
	"cmp",
	"defaults",
	"devicons",
	"git",
	"lsp",
	"mason",
	"statusline",
	"syntax",
	"treesitter",
	"telescope",
	"whichkey",
}

M.get_integrations = function()
	local integrations = { unpack(BASE_INTEGRATIONS) }
	for _, value in ipairs(opts.integrations) do
		if vim.g.hyde then
			if pcall(require, "chameleon.integrations." .. value) then
				table.insert(integrations, value)
			end
		else
			if pcall(require, "base46.integrations." .. value) then
				table.insert(integrations, value)
			end
		end
	end
	return integrations
end

M.base46_path = fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

local theme_cache = {}

function M.get_theme_tb(type)
	local cache_key = type .. (vim.g.nt or "")
	if theme_cache[cache_key] then
		return theme_cache[cache_key]
	end

	local name = vim.g.nt
	local theme

	local ok1, default_theme = pcall(require, "base46.themes." .. name)
	if ok1 then
		theme = default_theme[type]
	else
		local ok2, hyde_theme = pcall(require, "chameleon.colorschemes." .. name)
		if ok2 then
			theme = hyde_theme[type]
		else
			local ok3, user_theme = pcall(require, "themes." .. name)
			if ok3 then
				theme = user_theme[type]
			else
				error("No such theme!")
			end
		end
	end

	theme_cache[cache_key] = theme
	return theme
end

function M.merge_tb(...)
	return tbl_deep_extend("force", ...)
end

local transform_colors
if not g.hyde then
	local colors = require("chameleon.colors")
	local lighten = colors.change_hex_lightness
	local mixcolors = colors.mix

	transform_colors = function(val, colors)
		if type(val) == "string" then
			if val:sub(1, 1) ~= "#" and val ~= "none" and val ~= "NONE" then
				return colors[val]
			end
			return val
		elseif type(val) == "table" then
			return #val == 2 and lighten(colors[val[1]], val[2]) or mixcolors(colors[val[1]], colors[val[2]], val[3])
		end
		return val
	end
end

function M.turn_str_to_color(tb)
	local colors = M.get_theme_tb("base_30")
	local copy = deepcopy(tb)

	for _, hlgroups in pairs(copy) do
		for opt, val in pairs(hlgroups) do
			if opt == "fg" or opt == "bg" or opt == "sp" then
				hlgroups[opt] = transform_colors and transform_colors(val, colors) or val
			end
		end
	end

	return copy
end

function M.extend_default_hl(highlights, integration_name)
	local polish_hl = M.get_theme_tb("polish_hl")

	if polish_hl and polish_hl[integration_name] then
		highlights = M.merge_tb(highlights, polish_hl[integration_name])
	end

	if not g.hyde then
		if opts.transparency then
			local glassy = require("base46.glassy")
			for key, value in pairs(glassy) do
				if highlights[key] then
					highlights[key] = M.merge_tb(highlights[key], value)
				end
			end
		end

		local overriden_hl = M.turn_str_to_color(opts.hl_override)
		for key, value in pairs(overriden_hl) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end

	return highlights
end

function M.tb_2str(tb)
	local parts = {}
	for hlgroupName, v in pairs(tb) do
		local hlopts = {}
		for optName, optVal in pairs(v) do
			local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
				or ('"' .. optVal .. '"')
			table.insert(hlopts, optName .. "=" .. valueInStr)
		end
		table.insert(parts, string.format('vim.api.nvim_set_hl(0,"%s",{%s})', hlgroupName, table.concat(hlopts, ",")))
	end
	return table.concat(parts)
end

function M.str_to_cache(filename, str)
	local file = io.open(cache_path .. filename, "wb")
	if file then
		file:write(load("return string.dump(function()" .. str .. "end, true)")())
		file:close()
	end
end

M.get_integration = function(name)
	local highlights = g.hyde and require("chameleon.integrations." .. name) or require("base46.integrations." .. name)
	return M.extend_default_hl(highlights, name)
end

M.compile = function(integrations)
	if not vim.uv.fs_stat(vim.g.base46_cache) then
		fn.mkdir(cache_path, "p")
	end

	local term = string.format(
		"vim.g.nt='%s' vim.g.hyde=%s %s",
		g.nt,
		g.hyde,
		g.hyde and require("chameleon.term") or require("base46.term")
	)
	if require("chconf").ui.statusline.enabled then
		if vim.g.hyde then
			term = string.format("%s %s", neviline, term)
		else
			term = string.format("%s %s", stl, term)
		end
		get_statusline(vim.g.hyde)
	end

	M.str_to_cache("term", term)
	M.str_to_cache("colors", require("base46.color_vars"))

	for _, name in ipairs(integrations) do
		local hl_str = M.tb_2str(M.get_integration(name))

		if name == "defaults" then
			local theme_type = M.get_theme_tb("type")
			hl_str = string.format("vim.o.bg='%s' %s", theme_type, hl_str)
			if g.hyde then
				local borders = M.get_theme_tb("borders")
				hl_str = string.format("vim.g.b='%s' %s", borders, hl_str)
			end
		end

		M.str_to_cache(name, hl_str)
	end
end

M.load_all_highlights = function()
	require("plenary.reload").reload_module("base46")
	require("plenary.reload").reload_module("chameleon")
	local integrations = M.get_integrations()

	M.compile(integrations)

	for _, name in ipairs(integrations) do
		dofile(cache_path .. name)
	end

	pcall(function()
		require("ibl").update()
	end)
	api.nvim_exec_autocmds("User", { pattern = "NvThemeReload" })
end

M.override_theme = function(default_theme, theme_name)
	local changed_themes = opts.changed_themes
	return M.merge_tb(default_theme, changed_themes.all or {}, changed_themes[theme_name] or {})
end

M.toggle_transparency = function()
	if not pcall(require, "chameleon.colorschemes." .. vim.g.nt) then
		if fn.filereadable(fn.stdpath("data") .. "/transparency") == 1 then
			opts.transparency = false
			os.remove(fn.stdpath("data") .. "/transparency")
		else
			opts.transparency = true
			fn.writefile({}, fn.stdpath("data") .. "/transparency")
		end
		M.load_all_highlights()
	else
		print("Transparency is not supported for Hyde Themes")
	end
end

return M
