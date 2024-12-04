local M = {}

function M.get_theme_from_hypr()
	local hypr_conf_path = os.getenv("HOME") .. "/.config/hypr/themes/theme.conf"
	local hypr_conf_file = io.open(hypr_conf_path, "r")

	if hypr_conf_file then
		local hypr_conf_content = hypr_conf_file:read("*all")
		hypr_conf_file:close()

		---@type string
		local extracted_theme

		for line in hypr_conf_content:gmatch("[^\n]+") do
			if line:match("^%$GTK_THEME%s*=%s*") then
				extracted_theme = line:match("%$GTK_THEME%s*=%s*(.+)")
				extracted_theme = extracted_theme:gsub("^%s*", ""):gsub("%s*$", "") -- Trim whitespace
				break
			end
		end
		return extracted_theme
	end
end

return M
