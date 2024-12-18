local color = require('chameleon.colors').palette
local generate_color =
  require('chameleon.colors').change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type
local magenta = generate_color(color.magenta, vim_bg == 'dark' and 0 or -20)
-- TODO: change from pink to another
color.pink = generate_color(color.pink, vim_bg == 'dark' and 10 or 0)

return {
  ['@variable'] = { fg = color.white },
  ['@variable.builtin'] = { fg = color.yellow },
  ['@variable.parameter'] = { fg = color.pink },
  ['@variable.member'] = { fg = color.pink },
  ['@variable.member.key'] = { fg = color.pink },

  ['@module'] = { fg = color.pink },
  ['@module.builtin'] = { fg = color.pink },

  ['@constant'] = { fg = color.pink },
  ['@constant.builtin'] = { fg = color.yellow },
  ['@constant.macro'] = { fg = color.pink },

  ['@string'] = { fg = vim_bg == 'dark' and color.green or '#000000' },
  ['@string.regex'] = { fg = color.cyan },
  ['@string.escape'] = { fg = color.cyan },
  ['@character'] = { fg = color.pink },
  -- ["@character.special"] = { fg = color.pink },
  ['@number.float'] = { fg = color.yellow },

  ['@annotation'] = { fg = color.red },
  ['@attribute'] = { fg = color.bright_yellow },
  ['@error'] = { fg = color.pink },

  ['@keyword.exception'] = { fg = color.pink },
  ['@keyword'] = { fg = magenta, italic = true },
  ['@keyword.function'] = { fg = magenta, italic = true },
  ['@keyword.return'] = { fg = magenta, italic = true },
  ['@keyword.operator'] = { fg = magenta },
  ['@keyword.import'] = { link = 'Include' },
  ['@keyword.conditional'] = { fg = magenta, italic = true },
  ['@keyword.conditional.ternary'] = { fg = magenta, italic = true },
  ['@keyword.repeat'] = { fg = color.bright_yellow },
  ['@keyword.storage'] = { fg = color.bright_yellow },
  ['@keyword.directive.define'] = { fg = magenta },
  ['@keyword.directive'] = { fg = color.bright_yellow },

  ['@function'] = { fg = color.blue },
  ['@function.builtin'] = { fg = color.blue },
  ['@function.macro'] = { fg = color.pink },
  ['@function.call'] = { fg = color.blue },
  ['@function.method'] = { fg = color.blue },
  ['@function.method.call'] = { fg = color.blue },
  ['@constructor'] = { fg = color.cyan },

  ['@operator'] = { fg = color.white },
  ['@reference'] = { fg = color.white },
  ['@punctuation.bracket'] = { fg = color.red },
  ['@punctuation.delimiter'] = { fg = color.red },
  ['@symbol'] = { fg = color.green },
  ['@tag'] = { fg = color.bright_yellow },
  ['@tag.attribute'] = { fg = color.pink },
  ['@tag.delimiter'] = { fg = color.red },
  ['@text'] = { fg = color.white },
  ['@text.emphasis'] = { fg = color.yellow },
  ['@text.strike'] = { fg = color.red, strikethrough = true },
  ['@type.builtin'] = { fg = color.bright_yellow },
  ['@definition'] = { sp = color.grey, underline = true },
  ['@scope'] = { bold = true },
  ['@property'] = { fg = color.pink },

  -- markup
  ['@markup.heading'] = { fg = color.blue },
  ['@markup.raw'] = { fg = color.yellow },
  ['@markup.link'] = { fg = color.pink },
  ['@markup.link.url'] = { fg = color.yellow, underline = true },
  ['@markup.link.label'] = { fg = color.cyan },
  ['@markup.list'] = { fg = color.pink },
  ['@markup.strong'] = { bold = true },
  ['@markup.italic'] = { italic = true },
  ['@markup.strikethrough'] = { strikethrough = true },
  ['@markup.quote'] = { bg = color.black },

  ['@comment'] = { fg = color.grey },
  ['@comment.todo'] = { fg = color.grey, bg = color.white },
  ['@comment.warning'] = { fg = color.black, bg = color.yellow },
  ['@comment.note'] = { fg = color.black, bg = color.white },
  ['@comment.danger'] = { fg = color.black, bg = color.red },

  ['@diff.plus'] = { fg = color.green },
  ['@diff.minus'] = { fg = color.red },
  ['@diff.delta'] = { fg = color.grey },
}
