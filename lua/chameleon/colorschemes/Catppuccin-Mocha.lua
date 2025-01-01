---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "rounded"

M.colors = {
  background = "#1E1E2E",
  second_background = "#110e14",
  tab_background = "#83886B",
  foreground = "#D9E0EE",
  active_accent = "#D9E0EE",
  inactive_accent = "#43465A",

  black = "#282737",
  darker_black = "#191828",
  black2 = "#252434",
  one_bg2 = "#363545",
  grey = "#474656",
  white = "#D9E0EE",

  red = "#f38ba8",
  orange = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  cyan = "#89DCEB",
  blue = "#89b4fa",
  magenta = "#cba6f7",

  bright_black = "#43465A",
  pink = "#f5c2e7",
  bright_yellow = "#ffe9b6",
  bright_green = "#b6f4be",
  bright_magenta = "#d0a9e5",

  nord_blue = "#8bc2f0",
  baby_pink = "#ffa5c3",
  teal = "#B5E8E0",
  lavender = "#b4befe",
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
