local color = require('chameleon.colors').palette
local generate_color =
  require('chameleon.colors').change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type

local darker_bg =
  generate_color(color.background, vim_bg == 'dark' and -4 or -15)

return {
  NeoTreeNormal = {
    bg = darker_bg,
    fg = color.foreground,
  },
  NeoTreeNormalNC = { link = 'NeoTreeNormal' },
  NeoTreeEndOfBuffer = {
    bg = darker_bg,
  },
  NeoTreeCursorLine = { bg = color.black },

  NeoTreeDirectoryIcon = { link = 'Directory' },
  NeoTreeDirectoryName = { link = 'Directory' },

  NeoTreeRootDirectory = { fg = color.red, bold = true },
  NeoTreeOpenedDirectoryName = { link = 'Directory' },
  NeoTreeEmptyDirectoryName = { link = 'Directory' },

  NeoTreeGitDirty = { fg = color.red },
  NeoTreeIndentMarker = { fg = color.grey },

  NeoTreeWinSeparator = {
    bg = darker_bg,
    fg = darker_bg,
  },
  NeoTreeWindowPicker = { fg = color.red, bg = color.black },

  NeoTreeGitNew = { link = 'diffNewFile' },
  NeoTreeGitModified = {
    fg = generate_color(color.blue, vim_bg == 'dark' and 0 or 15),
  },
  NeoTreeGitDeleted = {
    fg = generate_color(color.red, vim_bg == 'dark' and 0 or 15),
  },
  NeoTreeGitIgnored = { fg = color.grey },

  NeoTreeSpecialFile = { fg = color.yellow, bold = true },
}
