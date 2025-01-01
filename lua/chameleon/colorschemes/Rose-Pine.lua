---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "rounded"

M.colors = {
  background = "#262431",
  second_background = "#13111e",
  active_accent = "#eb6f92",
  inactive_accent = "#cb5b7d",
  tab_background = "#83886B",
  foreground = "#e0def4",

  black = "#191724",
  white = "#e0def4",
  grey = "#3f3d4a",

  red = "#eb6f92",
  orange = "#f6c177",
  yellow = "#f6c177",
  green = "#ABE9B3",
  cyan = "#a3d6df",
  blue = "#8bbec7",
  magenta = "#bb9ede",

  teal = "#6aadc8",
  baby_pink = "#f5799c",
  nord_blue = "#86b9c2",
  pink = "#ff83a6",

  bright_green = "#b5f3bd",
  bright_magenta = "#c4a7e7",
  bright_yellow = "#fec97f",
  bright_black = "#282833",
}

M.base_16 = {
  base00 = M.colors.background,
  base01 = M.colors.second_background,
  base02 = M.colors.tab_background,
  base03 = M.colors.grey,
  base04 = M.colors.bright_black,
  base05 = M.colors.foreground,
  base06 = M.colors.teal,
  base07 = M.colors.white,
  base08 = M.colors.red,
  base09 = M.colors.orange,
  base0A = M.colors.yellow,
  base0B = M.colors.green,
  base0C = M.colors.cyan,
  base0D = M.colors.blue,
  base0E = M.colors.magenta,
  base0F = M.colors.pink,
}

return M
