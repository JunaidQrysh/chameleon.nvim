---@type Colorscheme
local M = {}

M.type = "dark"
M.borders = "rounded"

M.colors = {
  background = "#282c34",
  second_background = "#1b1f27",
  foreground = "#D9E0EE",
  tab_background = "#282c34",
  active_accent = "#7eca9c",
  inactive_accent = "#519aba",

  white = "#abb2bf",
  black = "#1e222a",
  grey = "#42464e",

  red = "#e06c75",
  orange = "#fca2aa",
  yellow = "#e7c787",
  green = "#98c379",
  cyan = "#a3b8ef",
  blue = "#61afef",
  magenta = "#c882e7",

  teal = "#519ABA",
  nord_blue = "#81A1C1",
  baby_pink = "#DE8C92",
  pink = "#ff75a0",

  bright_yellow = "#EBCB8B",
  bright_green = "#7eca9c",
  bright_magenta = "#de98fd",
  bright_black = "#353535",
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
  defaults = {
    Visual = {
      bg = M.colors.black,
    },
  },
}

return M
