---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "rounded"

M.colors = {
  background = "#0d0f18",
  second_background = "#0d0f18",
  tab_background = "#83886B",
  foreground = "#a5b6cf",
  active_accent = "#A6BAB5",
  inactive_accent = "#556B6B",

  white = "#cbced3",
  black = "#171B20", --  nvim bg
  grey = "#41454a",

  red = "#e26c7c",
  orange = "#e9a180",
  yellow = "#ecd3a0",
  green = "#78DBA9",
  cyan = "#98d3ee",
  blue = "#86aaec",
  magenta = "#b77bdf",

  baby_pink = "#c79bf0",
  pink = "#c296eb",
  nord_blue = "#96b5ee",
  teal = "#7ddac5",

  bright_black = "#1c1e27",
  bright_green = "#87eab8",
  bright_yellow = "#f1d8a5",
  brigth_magenta = "#c68aee",
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
  ["@constant"] = { fg = M.colors.yellow },
}

return M
