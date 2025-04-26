local str = ""

local present1, default_theme = pcall(require, "base46.themes." .. vim.g.nt)
local colors = (present1 and default_theme) or require("themes." .. vim.g.nt)

for name, hex in pairs(colors.base_30) do
  str = str .. name .. "='" .. hex
  str = str .. "',"
end

str = "return {" .. str .. "}"

return str
