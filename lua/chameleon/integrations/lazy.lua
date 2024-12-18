local color = require('chameleon.colors').palette
local generate_color =
  require('chameleon.colors').change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type

return {
  LazyH1 = {
    bg = color.inactive_accent,
    fg = generate_color(color.active_accent, vim_bg == 'dark' and 10 or 20),
  },

  LazyButton = {
    fg = generate_color(color.active_accent, vim_bg == 'dark' and 10 or -20),
  },
  LazyButtonActive = {
    bg = color.inactive_accent,
    fg = generate_color(color.active_accent, vim_bg == 'dark' and 10 or 20),
  },

  LazyH2 = {
    fg = color.red,
    bold = true,
    underline = true,
  },
  LazyNormal = { bg = color.background },
  LazyReasonPlugin = { fg = color.red },
  LazyValue = { fg = color.teal },
  LazyDir = { fg = color.white },
  LazyUrl = { fg = color.white },
  LazyCommit = { fg = color.blue },
  LazyNoCond = { fg = color.red },
  LazySpecial = { fg = color.green },
  LazyReasonFt = { fg = color.purple },
  LazyOperator = { fg = color.white },
  LazyReasonKeys = { fg = color.teal },
  LazyTaskOutput = { fg = color.white },
  LazyCommitIssue = { fg = color.pink },
  LazyReasonEvent = { fg = color.yellow },
  LazyReasonStart = { fg = color.white },
  LazyReasonRuntime = { fg = color.nord_blue },
  LazyReasonCmd = { fg = color.sun },
  LazyReasonSource = { fg = color.cyan },
  LazyReasonImport = { fg = color.white },
  LazyProgressDone = { fg = color.blue },
}
