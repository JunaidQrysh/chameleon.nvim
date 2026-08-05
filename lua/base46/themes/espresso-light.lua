local M = {}

M.base_30 = {
  white        = "#383838",
  darker_black = "#f0f0f0",
  black        = "#ffffff",
  black2       = "#f8f8f8",
  one_bg       = "#f3f3f3",
  one_bg2      = "#ededed",
  one_bg3      = "#e2e2e2",
  grey         = "#c7c7c7",
  grey_fg      = "#999999",
  grey_fg2     = "#7c7c7c",
  light_grey   = "#525252",
  red          = "#e03434",
  baby_pink    = "#f79596",
  pink         = "#e34aa6",
  line         = "#e2e2e2",
  green        = "#268c5c",
  vibrant_green= "#43ac79",
  nord_blue    = "#077ddf",
  blue         = "#0d8ef8",
  yellow       = "#df9311",
  sun          = "#c97d00",
  purple       = "#9c45e3",
  dark_purple  = "#7757ee",
  teal         = "#36baad",
  orange       = "#e86c13",
  cyan         = "#3bbde5",
  statusline_bg= "#f0f0f0",
  lightbg      = "#ededed",
  pmenu_bg     = "#5e5f65",
  folder_bg    = "#0d8ef8",
}

M.base_16 = {
  base00 = "#ffffff",
  base01 = "#f8f8f8",
  base02 = "#ededed",
  base03 = "#e2e2e2",
  base04 = "#c7c7c7",
  base05 = "#383838",
  base06 = "#171717",
  base07 = "#000000",
  base08 = "#0781e5",  -- blue      → identifiers, members, params
  base09 = "#902fe0",  -- purple    → numbers, constants, booleans
  base0A = "#21784f",  -- green     → types, tags, let/const/for
  base0B = "#c7830f",  -- yellow    → strings
  base0C = "#d92121",  -- red       → special, regex, constructor
  base0D = "#30a69b",  -- teal      → functions
  base0E = "#d06111",  -- orange    → keywords
  base0F = "#888888",  -- grey      → delimiters, punctuation
}

M.type = "light"

M.polish_hl = {
  telescope = {
    TelescopePromptPrefix = { fg = M.base_30.white },
    TelescopeSelection = { bg = M.base_30.one_bg, fg = M.base_30.white },
  },

  defaults = {
    FloatBorder = { fg = M.base_16.base05 },
    Pmenu = { bg = M.base_30.black2 },
  },

  tbline = {
    TbLineThemeToggleBtn = { bg = M.base_30.one_bg3 },
  },

  whichkey = { WhichKeyDesc = { fg = M.base_30.white } },
  statusline = { St_pos_text = { fg = M.base_30.white } },
}

M = require("base46").override_theme(M, "espresso-light")

return M
