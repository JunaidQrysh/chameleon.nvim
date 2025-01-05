local M = {}

local PATHS = {
	hyde = vim.fn.stdpath("data") .. "/hyde",
	hypr_conf = os.getenv("HOME") .. "/.config/hypr/themes/theme.conf",
	wallbash = vim.loop.fs_readlink(vim.fn.expand("$HOME") .. "/.cache/hyde/wall.dcol"),
	base46_cache = vim.fn.stdpath("data") .. "/base46/",
}

M.chameleon_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

local function write_to_file(path, content)
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	end
end

local function read_file(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read("*all")
		file:close()
		return content
	end
end

local function get_modification_time(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.mtime.sec or nil
end

local reload_attempts = 0
local MAX_ATTEMPTS = 2

local function reload_hyde()
	local chameleon = require("chameleon")

	if chameleon.opts or reload_attempts >= MAX_ATTEMPTS then
		vim.g.hyde = true
		vim.g.hyde_int = true
		vim.g.base46_cache = PATHS.base46_cache
		require("base46").load_all_highlights()
		return
	end

	reload_attempts = reload_attempts + 1
	vim.schedule(function()
		reload_hyde()
	end)
end

function M.write_modtime(mod_time)
	write_to_file(PATHS.hyde, tostring(mod_time))
end

function M.get_theme_from_hypr()
	local content = read_file(PATHS.hypr_conf)
	if not content then
		os.remove(PATHS.hyde)
		print("Hyde Not Found")
		return nil
	end

	local theme = content:match("\n?%$GTK[_%-]THEME%s*=%s*([^\n]+)")
	if not theme then
		print("GTK-THEME Not Found in $HOME/.config/hypr/themes/theme.conf")
		return nil
	end

	return theme:match("^%s*(.-)%s*$") -- Trim spaces
end

function M.set_hyde()
	local hyde_theme = M.get_theme_from_hypr()
	if not hyde_theme then
		return
	end

	if hyde_theme ~= vim.g.nt then
		local theme_path = string.format("%s/colorschemes/%s.lua", M.chameleon_path, hyde_theme)
		local theme_file = io.open(theme_path, "r")

		if theme_file then
			theme_file:close()
			vim.g.nt = hyde_theme
			reload_hyde()
			M.write_modtime(get_modification_time(PATHS.wallbash))
		else
			print("Matching Theme Not Found")
		end
	elseif hyde_theme == vim.g.nt then
		local saved_time = tonumber(read_file(PATHS.hyde) or "0")
		local current_time = get_modification_time(PATHS.wallbash)

		if saved_time ~= current_time then
			reload_hyde()
			M.write_modtime(current_time)
		end
	end
end

function M.toggle_hyde()
	if vim.fn.filereadable(PATHS.hyde) == 1 then
		os.remove(PATHS.hyde)
		print("Hyde Integration Off")
	else
		M.set_hyde()
		if vim.g.hyde_int then
			print("Hyde Integration On")
		end
	end
end

return M
