local color = require('chameleon.colors').palette
local generate_color =
  require('chameleon.colors').change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type

local syntax = {
  Boolean = {
    fg = generate_color(color.yellow, vim_bg == 'dark' and 0 or -10),
  },
  Character = { fg = color.pink },
  Conditional = { fg = color.magenta },
  Constant = { fg = color.pink },
  Define = { fg = color.magenta, sp = 'none' },
  Delimiter = { fg = color.red },
  Float = { fg = color.yellow },
  Variable = { fg = color.white },
  Function = { fg = color.green },
  Identifier = { fg = color.pink, sp = 'none' },
  Include = { fg = color.green, italic = true },
  Keyword = { fg = color.magenta, italic = true },
  Label = { fg = color.bright_yellow },
  Number = { fg = color.yellow },
  Operator = { fg = color.white, sp = 'none' },
  PreProc = { fg = color.bright_yellow },
  Repeat = { fg = color.bright_yellow },
  Special = { fg = color.cyan },
  SpecialChar = { fg = color.red },
  Statement = { fg = color.pink },
  StorageClass = { fg = color.bright_yellow },
  String = { fg = color.green },
  Structure = { fg = color.magenta },
  Tag = { fg = color.bright_yellow },
  Todo = { fg = color.bright_yellow, bg = color.black },
  Type = { fg = color.bright_yellow, sp = 'none' },
  Typedef = { fg = color.bright_yellow },
}

return syntax
