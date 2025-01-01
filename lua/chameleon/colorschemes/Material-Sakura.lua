---@type Colorscheme
local M = {}

M.type = "light"
M.borders = "solid"

M.colors = {
  background = "#bcc0cc",
  second_background = "#9ca0b0",
  tab_background = "#83886B",
  active_accent = "#575279",
  inactive_accent = "#776c79",
  foreground = "#4c4f69",

  white = "#f2e9de",
  black = "#faf4ed",
  grey = "#8c8fa1",

  red = "#d20f39",
  orange = "#d7827e",
  yellow = "#ea9d34",
  green = "#40a02b",
  cyan = "#04a5e5",
  blue = "#1e66f5",
  magenta = "#907aa9",

  teal = "#56949f",
  nord_blue = "#8bc2f0",
  lavender = "#7287fd",
  baby_pink = "#ffa5c3",
  pink = "#ea76cb",

  bright_yellow = "#ffe9b6",
  bright_green = "#b6f4be",
  bright_magenta = "#d0a9e5",
  bright_black = "#808080",
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
