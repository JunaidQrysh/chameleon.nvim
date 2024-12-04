vim.g.nt = require("chameleon.hyprdots").get_theme_from_hypr() or "Tokyo-Night"

local M = {}

M.config = {
	hyde = false,
}

function M.setup(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})

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

	if M.config.hyde then
		require("chameleon.nui").change_theme(vim.g.nt)
	else
		local file = io.open(vim.fn.stdpath("data") .. "/theme", "r")
		if file then
			vim.g.nt = file:read("*a")
			file:close()
		end
	end
	require("chameleon.utils").load_all_highlights()
end

return M
