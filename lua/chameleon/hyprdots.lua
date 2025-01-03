local M = {}

local hyde_path = vim.fn.stdpath("data") .. "/hyde"
local hypr_conf_path = os.getenv("HOME") .. "/.config/hypr/themes/theme.conf"
local wallbash_path = vim.loop.fs_readlink(vim.fn.expand("$HOME") .. "/.cache/hyde/wall.dcol")

M.chameleon_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
M.hyde_theme = ""

local function write_to_file(path, content)
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
		return true
	end
	return false
end

local function read_file(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read("*all")
		file:close()
		return content
	end
	return nil
end

local function get_modification_time(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.mtime.sec or nil
end

function M.write_modtime(mod_time)
	write_to_file(hyde_path, tostring(mod_time))
end

function M.get_theme_from_hypr()
	local content = read_file(hypr_conf_path)
	if content then
		local theme = content:match("\n?%$GTK[_%-]THEME%s*=%s*([^\n]+)")
		if theme then
			theme = theme:match("^%s*(.-)%s*$") -- Trim spaces
			M.hyde_theme = theme
			return theme
		end
		print("GTK-/_THEME Not Found in $HOME/.config/hypr/themes/theme.conf")
		return nil
	end
	print("Hyde Not Found")
	os.remove(hyde_path)
	return nil
end

function M.set_hyde()
	local hyde_theme = M.get_theme_from_hypr()
	if not hyde_theme or M.hyde_theme == "" then
		return
	end

	if hyde_theme ~= vim.g.nt then
		local theme_path = M.chameleon_path .. "/colorschemes/" .. hyde_theme .. ".lua"
		local theme_file = io.open(theme_path, "r")
		if theme_file then
			theme_file:close()
			vim.g.hyde_int = true
			require("tswitch.utils").reload_theme(hyde_theme)
			M.write_modtime(get_modification_time(wallbash_path))
		else
			print("Matching Theme Not Found")
		end
	elseif hyde_theme == vim.g.nt then
		local saved_mod_time_str = read_file(hyde_path)
		local saved_mod_time = saved_mod_time_str and tonumber(saved_mod_time_str)

		local current_mod_time = get_modification_time(wallbash_path)
		if saved_mod_time ~= current_mod_time then
			vim.g.hyde = true
			vim.g.hyde_int = true
			vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
			require("base46").load_all_highlights()
			M.write_modtime(current_mod_time)
		end
	end
end

function M.toggle_hyde()
	local file = io.open(hyde_path, "r")
	if file then
		file:close()
		os.remove(hyde_path)
		M.hyde_theme = ""
		print("Hyde Integration Off")
	else
		M.set_hyde()
		if M.hyde_theme ~= "" then
			print("Hyde Integration On")
		end
	end
end

return M
