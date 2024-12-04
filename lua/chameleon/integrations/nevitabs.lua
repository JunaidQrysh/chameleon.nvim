local color = require('chameleon.colors').palette

local gc = require('chameleon.colors').change_hex_lightness
local darker_bg = gc(color.background, vim.o.bg == 'dark' and -3 or -15)

local cg =
  require('chameleon.colors').compute_gradient
local fade = cg(color.tab_background, color.background, 5)

local tab_styles = {
  fade = {
    TbSepFade1 = { fg = fade[2] },
    TbSepFade2 = { fg = fade[3] },
    TbSepFade3 = { fg = fade[4] },
    TbLineBufOn = {
      fg = color.background,
      bg = color.tab_background,
      bold = true,
    },
    TbLineBufOff = {
      fg = color.tab_background,
      bg = color.background,
    },
    BufTabLineFill = {
      bg = color.background,
    },
    BufTabDate = {
      fg = color.tab_background,
      bg = color.background,
      italic = true,
    },
    TbLineBufOnModified = {
      fg = gc(color.green, 15),
      bg = color.tab_background,
      italic = true,
    },
    TbLineBufOffModified = {
      fg = color.red,
      bg = color.background,
      italic = true,
    },
    TbLineBufOnClose = {
      fg = gc(color.red, -15),
      bg = color.tab_background,
      bold = true,
    },
    TbLineBufOffClose = {
      fg = color.grey,
      bg = color.background,
    },
  },

  slant = {
    TbSepSlant = {
      fg = color.background,
      bg = color.second_background,
      bold = true,
    },
    TbLineBufOn = {
      fg = color.foreground,
      bg = color.background,
      bold = true,
    },
    TbLineBufOff = {
      fg = color.grey,
      bg = color.second_background,
    },
    BufTabLineFill = {
      bg = color.second_background,
    },
    BufTabDate = {
      fg = color.inactive_accent,
      bg = color.tab_background,
      italic = true,
    },
    TbLineBufOnModified = {
      fg = color.green,
      bg = color.background,
      italic = true,
    },
    TbLineBufOffModified = {
      fg = color.red,
      bg = color.second_background,
      italic = true,
    },
    TbLineBufOnClose = { fg = color.red, bg = color.tab_background },
    TbLineBufOffClose = {
      fg = color.grey,
      bg = color.second_background,
    },
  },
}

local highlights = {
  PomoTimer = {
    bg = color.inactive_accent,
    fg = darker_bg,
    bold = true,
  },

  TbSeparator = {
    fg = color.background,
    bg = darker_bg,
    bold = true,
  },
  TblineTabNewBtn = { fg = color.white, bg = color.black, bold = true },
  TbLineTabOn = { fg = color.background, bg = color.nord_blue, bold = true },
  TbLineTabOff = { fg = color.white, bg = color.black },
  TbLineTabCloseBtn = { fg = color.background, bg = color.nord_blue },
  TBTabTitle = { fg = color.background, bg = color.white },
  TbLineThemeToggleBtn = { bold = true, fg = color.white, bg = color.black },
  CloseAllBufsBtn = {
    bold = true,
    bg = color.red,
    fg = color.background,
  },
}

local kitty_style = 'slant'

local current_style = tab_styles[kitty_style]

if current_style then
  highlights = vim.tbl_deep_extend('force', highlights, current_style)
end

return highlights
