---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "single"

M.colors = {
  background = "#282b2c",
  tab_background = "#83886B",
  second_background = "#1a1d1e",
  foreground = "#575a5b",
  active_accent = "#D9E0EE",
  inactive_accent = "#43465A",

  white = "#c7b89d",
  black = "#282828",
  grey = "#484b4c",

  red = "#ec6b64",
  orange = "#e78a4e",
  yellow = "#d6b676",
  green = "#89b482",
  cyan = "#82b3a8",
  blue = "#6d8dad",
  magenta = "#887aa9",

  nord_blue = "#6f8faf",
  teal = "#749689",
  baby_pink = "#ce8196",
  pink = "#ff75a0",

  bright_black = "#43465A",
  bright_yellow = "#d1c555",
  bright_green = "#a9b665",
  bright_magenta = "#9385b4",
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
  syntax = {
    Operator = { fg = M.colors.nord_blue },
  },

  treesitter = {
    ["@operator"] = { fg = M.colors.nord_blue },
  },
}

return M
