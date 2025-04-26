vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
local ok, _ = pcall(dofile, vim.g.base46_cache .. "term")
if not ok then
  vim.g.nt = "catppuccin"
  require("base46").load_all_highlights()
end
if vim.loop.fs_stat(vim.fn.stdpath "data" .. "/hyde") ~= nil then
  require("chameleon.hyprdots").set_hyde()
end
