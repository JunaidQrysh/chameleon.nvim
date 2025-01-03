local str = ""
local colors

local ok1, default_theme = pcall(require, "base46.themes." .. vim.g.nt)
local ok2, user_theme = pcall(require, "themes." .. vim.g.nt)
if ok1 or ok2 then
  colors = (default_theme or user_theme).base_30
else
  colors = require("chameleon.colorschemes." .. vim.g.nt).colors
end

for name, hex in pairs(colors) do
  str = str .. name .. "='" .. hex
  str = str .. "',"
end

str = "return {" .. str .. "}"

return str
