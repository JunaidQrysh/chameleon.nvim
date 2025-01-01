local color = require("chameleon.colors").palette
local generate_color = require("chameleon.colors").change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type

local defaults = {
  LineSeparator = {
    link = "WinSeparator",
  },

  MatchWord = {
    bg = color.grey,
    fg = color.white,
  },

  WinBar = { bg = color.background },
  WinBarNC = { link = "WinBar" },

  -- cmdline menu
  Pmenu = { bg = color.second_background, fg = color.active_accent },
  PmenuSbar = { bg = color.second_background },
  PmenuSel = {
    bg = color.inactive_accent,
    fg = color.second_background,
    bold = true,
  },
  PmenuThumb = { bg = color.red },

  MatchParen = { link = "MatchWord" },

  Comment = { fg = color.grey, italic = true },

  CursorLineNr = { fg = color.white },
  LineNr = { fg = color.grey },

  -- floating windows
  FloatBorder = { fg = color.inactive_accent },
  NormalFloat = { bg = "none" },

  NvimInternalError = { fg = color.red },

  WinSeparator = {
    fg = color.second_background,
    -- bg = color.second_background,
  },

  Normal = {
    fg = color.foreground,
    bg = color.background,
  },

  Bold = {
    bold = true,
  },

  Debug = {
    fg = color.pink,
  },

  Directory = {
    fg = color.inactive_accent,
    bold = true,
  },

  Error = {
    fg = color.background,
    bg = color.pink,
  },

  ErrorMsg = {
    fg = color.pink,
    bg = color.background,
  },

  Exception = {
    fg = color.pink,
  },

  FoldColumn = {
    fg = color.cyan,
    bg = color.black,
  },

  Folded = {
    fg = color.bright_black,
    bg = color.black,
  },

  IncSearch = {
    fg = color.background,
    bg = color.orange,
  },

  Italic = {
    italic = true,
  },

  Macro = {
    fg = color.pink,
  },

  ModeMsg = {
    fg = color.blue,
  },

  MoreMsg = {
    fg = color.blue,
  },

  Question = {
    fg = color.bright_blue,
  },

  Search = {
    fg = color.black,
    bg = color.bright_yellow,
  },

  Substitute = {
    fg = color.black,
    bg = color.bright_yellow,
    sp = "none",
  },

  SpecialKey = {
    fg = color.bright_black,
  },

  TooLong = {
    fg = color.pink,
  },

  UnderLined = {
    underline = true,
  },

  Visual = {
    bg = generate_color(color.grey, vim_bg == "dark" and -10 or 10),
  },
  VisualNOS = {
    fg = color.pink,
  },

  WarningMsg = {
    fg = color.pink,
  },

  WildMenu = {
    fg = color.pink,
    bg = color.bright_yellow,
  },

  Title = {
    fg = color.active_accent,
    sp = "none",
  },

  Conceal = {
    bg = "NONE",
  },

  Cursor = {
    fg = color.background,
    bg = color.white,
  },

  NonText = {
    fg = generate_color(color.bright_black, vim_bg == "dark" and 0 or 30),
  },

  SignColumn = {
    fg = color.bright_black,
    sp = "NONE",
  },

  ColorColumn = {
    bg = color.black,
    sp = "none",
  },

  CursorLine = {
    bg = generate_color(color.black, vim_bg == "dark" and -10 or 50),
    sp = "none",
  },

  QuickFixLine = {
    bg = color.black,
    sp = "none",
  },

  -- spell
  SpellBad = {
    undercurl = true,
    sp = color.pink,
  },

  SpellLocal = {
    undercurl = true,
    sp = color.cyan,
  },

  SpellCap = {
    undercurl = true,
    sp = color.bright_blue,
  },

  SpellRare = {
    undercurl = true,
    sp = color.magenta,
  },

  healthSuccess = {
    bg = color.blue,
    fg = color.backgroung,
  },

  NeviraideTerminalDarkerBG = {
    bg = generate_color(color.background, vim_bg == "dark" and -3 or 15),
  },
  NeviraideHelpDarkerBG = {
    bg = generate_color(color.background, vim_bg == "dark" and -3 or 15),
  },
  NeviraideTerminalWinbar = {
    bg = generate_color(color.background, vim_bg == "dark" and -3 or 15),
  },
}

local merge_tb = require("base46").merge_tb
defaults = merge_tb(defaults, require("base46").get_integration("neviline"))

defaults.NuiTitle = { bg = "none", fg = color.active_accent, bold = true }

return defaults
