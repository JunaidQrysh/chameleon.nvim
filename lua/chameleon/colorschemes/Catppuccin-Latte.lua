---@type Colorscheme
local M = {}

M.type = "light"
M.borders = "rounded"

M.colors = {
  background = "#EFF1F5",
  second_background = "#9CA0B0",
  tab_background = "#83886B",
  foreground = "#4C4F69",
  active_accent = "#8839EF",
  inactive_accent = "#8839EF",

  white = "#4c4f69",
  black = "#eff1f5",
  grey = "#8c8fa1",

  red = "#d20f39",
  orange = "#fe640b",
  yellow = "#df8e1d",
  green = "#40a02b",
  cyan = "#04a5e5",
  blue = "#1e66f5",
  magenta = "#8839ef",

  bright_green = "#b6f4be",
  bright_yellow = "#df8e1d",
  brigth_magenta = "#d0a9e5",
  bright_black = "#7d6d87",

  baby_pink = "#ffa5c3",
  pink = "#ea76cb",
  nord_blue = "#8bc2f0",
  teal = "#176c83",
  lavender = "#7287fd",
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
    ["@variable"] = { fg = M.colors.lavender },
    ["@property"] = { fg = M.colors.teal },
    ["@variable.builtin"] = { fg = M.colors.red },
  },
}

return M
