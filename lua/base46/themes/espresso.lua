local M = {}

M.base_30 = {
  white        = "#d9d9d9",
  darker_black = "#0d0d0d",
  black        = "#171717",
  black2       = "#1f1f1f",
  one_bg       = "#242424",
  one_bg2      = "#292929",
  one_bg3      = "#383838",
  grey         = "#424242",
  grey_fg      = "#575757",
  grey_fg2     = "#7a7a7a",
  light_grey   = "#888888",
  red          = "#ff7575",
  baby_pink    = "#ffc1c1",
  pink         = "#ed77be",
  line         = "#2e2e2e",
  green        = "#7dc5a2",
  vibrant_green= "#9be6c1",
  nord_blue    = "#349bef",
  blue         = "#76bef9",
  yellow       = "#e9a144",
  sun          = "#f4c25f",
  purple       = "#c993ef",
  dark_purple  = "#baa8f5",
  teal         = "#51decf",
  orange       = "#fa8a40",
  cyan         = "#62cae9",
  statusline_bg= "#1e1e1e",
  lightbg      = "#242424",
  pmenu_bg     = "#9be6c1",
  folder_bg    = "#76bef9",
}

M.base_16 = {
  base00 = "#171717",
  base01 = "#1f1f1f",
  base02 = "#292929",
  base03 = "#575757",
  base04 = "#7a7a7a",
  base05 = "#d9d9d9",
  base06 = "#f8f8f8",
  base07 = "#ffffff",
  base08 = "#76bef9",  -- blue      → identifiers, members, params
  base09 = "#c993ef",  -- purple    → numbers, constants, booleans
  base0A = "#7dc5a2",  -- green     → types, tags, let/const/for
  base0B = "#f4c25f",  -- sun/yellow → strings
  base0C = "#ff7575",  -- red       → special, regex, constructor
  base0D = "#51decf",  -- teal      → functions
  base0E = "#fa8a40",  -- orange    → keywords
  base0F = "#575757",  -- grey_fg   → delimiters, punctuation
}

M.type = "dark"

M = require("base46").override_theme(M, "espresso")

return M
