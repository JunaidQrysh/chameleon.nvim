vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
local ok, _ = pcall(dofile, vim.g.base46_cache .. "term")
if not ok then
	vim.g.nt = "catppuccin"
	require("base46").load_all_highlights()
	package.loaded["chconf"] = nil
end
local file = io.open(vim.fn.stdpath("data") .. "/hyde", "r")
if file then
	file:close()
	require("chameleon.hyprdots").set_hyde()
end
