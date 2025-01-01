---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "double"

M.colors = {
  background = "#000000",
  second_background = "#000000",
  tab_background = "#83886B",
  foreground = "#FDF500",
  active_accent = "#fdf600",
  inactive_accent = "#43465A",

  white = "#D8DEE9",
  black = "#1F2229",
  grey = "#424242",

  red = "#D62246",
  orange = "#efb6a0",
  yellow = "#FDF500",
  green = "#4DBD4F",
  cyan = "#2CF6B3",
  blue = "#F29C6B",
  magenta = "#A56DF2",

  nord_blue = "#FFA6C2",
  teal = "#37EBF3",
  baby_pink = "#eca8a8",
  pink = "#da838b",

  bright_black = "#1b1c22",
  bright_red = "#ec0101",
  bright_yellow = "#eff6ab",
  bright_green = "#1F5322",
  bright_magenta = "#564873",
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
  defaults = {
    FloatBorder = { fg = M.colors.yellow },
  },
}

return M
