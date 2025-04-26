local stl = require("chameleon").ui.statusline

if not stl.enabled then
  return {}
end

local theme_module = "base46.integrations.statusline." .. stl.theme
return require(theme_module)
