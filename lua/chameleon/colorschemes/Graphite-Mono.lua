---@type Colorscheme
local M = {}

M.borders = "solid"
M.type = "dark"

M.colors = {
  background = "#242424",
  second_background = "#09161c",
  tab_background = "#83886B",
  foreground = "#ffffff",
  active_accent = "#D9E0EE",
  inactive_accent = "#43465A",

  white = "#D8DEE9",
  black = "#101010",
  grey = "#424242",

  red = "#ec8989",
  orange = "#efb6a0",
  yellow = "#ffe6b5",
  green = "#c9d36a",
  cyan = "#9aafe6",
  blue = "#8abae1",
  magenta = "#db9fe9",

  nord_blue = "#a5c6e1",
  teal = "#6484a4",
  baby_pink = "#eca8a8",
  pink = "#da838b",

  bright_yellow = "#eff6ab",
  bright_black = "#1a1a1a",
  bright_green = "#eff6ab",
  bright_magenta = "#e1bee9",
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

M.polish_hl = {
  treesitter = {
    ["@punctuation.bracket"] = { fg = M.colors.red },
  },
}

return M
