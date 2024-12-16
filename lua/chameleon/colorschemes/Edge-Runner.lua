---@type Colorscheme
local M = {}

M.type = 'dark'
M.borders = 'double'

M.colors = {
  background = '#000000',
  second_background = '#000000',
  tab_background = '#83886B',
  foreground = '#FDF500',
  active_accent = '#fdf600',
  inactive_accent = '#43465A',

  white = '#D8DEE9',
  black = '#1F2229',
  grey = '#424242',

  red = '#D62246',
  orange = '#efb6a0',
  yellow = '#FDF500',
  green = '#4DBD4F',
  cyan = '#2CF6B3',
  blue = '#F29C6B',
  magenta = '#A56DF2',

  nord_blue = '#FFA6C2',
  teal = '#37EBF3',
  baby_pink = '#eca8a8',
  pink = '#da838b',

  bright_black = '#1b1c22',
  bright_red = '#ec0101',
  bright_yellow = '#eff6ab',
  bright_green = '#1F5322',
  bright_magenta = '#564873',
}

M.polish_hl = {
  treesitter = {
    ['@punctuation.bracket'] = { fg = M.colors.red },
  },
  defaults = {
    FloatBorder = { fg = M.colors.yellow },
  },
}

return M
