vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
local ok, _ = pcall(dofile, vim.g.base46_cache .. "term")
if not ok then
  vim.g.nt = "catppuccin"
  require("base46").load_all_highlights()
  vim.schedule(function()
    require("plenary.reload").reload_module "base46"
    require("base46").load_all_highlights()
  end)
end
if vim.loop.fs_stat(vim.fn.stdpath "data" .. "/hyde") ~= nil then
  require("chameleon.hyprdots").set_hyde()
end
