local M = {}

function M.setup()
	require("which-key").add({
		{
			"<leader>sC",
			function()
				require("chameleon.nui").choose_theme()
			end,
			desc = "Colorscheme",
		},
	})

	require("which-key").add({
		{
			"<leader>sT",
			function()
				require("chameleon.utils").ToggleHyde()
			end,
			desc = "Toggle-Hyde",
		},
	})

	local file = io.open(vim.fn.stdpath("data") .. "/theme", "r")
	if file then
		M.hyde = false
		vim.g.nt = file:read("*a")
		file:close()
	else
		M.hyde = true
		vim.g.nt = require("chameleon.hyprdots").get_theme_from_hypr() or "Tokyo-Night"
		local file_path = require("chameleon.utils").chameleon_path .. "/colorschemes/" .. vim.g.nt .. ".lua"
		local file1 = io.open(file_path, "r")
		if file1 then
			file1:close()
		else
			vim.g.nt = "Tokyo-Night"
		end
	end
	require("chameleon.nui").change_theme(vim.g.nt)
	require("chameleon.utils").load_all_highlights()
end

return M
