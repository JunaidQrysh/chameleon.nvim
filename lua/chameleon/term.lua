local color = require("chameleon.colors").palette

local config = string.format(
  [[
vim.g.terminal_color_0 = "%s" vim.g.terminal_color_1 = "%s" vim.g.terminal_color_2 = "%s" vim.g.terminal_color_3 = "%s" vim.g.terminal_color_4 = "%s" vim.g.terminal_color_5 = "%s" vim.g.terminal_color_6 = "%s" vim.g.terminal_color_7 = "%s" vim.g.terminal_color_8 = "%s" vim.g.terminal_color_9 = "%s" vim.g.terminal_color_10 = "%s" vim.g.terminal_color_11 = "%s" vim.g.terminal_color_12 = "%s" vim.g.terminal_color_13 = "%s" vim.g.terminal_color_14 = "%s" vim.g.terminal_color_15 = "%s"
]],
  color.black,
  color.red,
  color.green,
  color.yellow,
  color.blue,
  color.magenta,
  color.cyan,
  color.white,
  color.grey,
  color.pink,
  color.bright_blue,
  color.bright_yellow,
  color.bright_green,
  color.bright_magenta,
  color.bright_cyan,
  color.bright_white
)

return config
