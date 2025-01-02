local color = require('chameleon.colors').palette
local merge_tb = vim.tbl_deep_extend

local Lsp_highlights = {
  St_lspError = { fg = color.red, bg = 'none' },
  St_lspWarning = { fg = color.orange, bg = 'none' },
  St_LspHints = { fg = color.magenta, bg = 'none' },
  St_LspInfo = { fg = color.blue, bg = 'none' },
}

local default = {
  StatusLine = { bg = 'none' },
  St_gitIcons = { fg = color.grey, bg = 'none', bold = true },
  St_LspStatus = { fg = color.grey, bg = 'none' },
  St_LspStatus_Icon = { fg = color.nord_blue, bg = 'none' },
  St_EmptySpace = { fg = color.grey, bg = color.lightbg },
  St_EmptySpace2 = { fg = color.grey, bg = 'none' },
  St_location = { fg = color.grey, bg = 'none', bold = true },
  St_spaces = { fg = color.grey, bg = 'none' },
  St_encoding = { fg = color.grey, bg = 'none' },
  St_fileformat = { fg = color.grey, bg = 'none' },
  St_filesize = { fg = color.grey, bg = 'none' },
  St_interpreter = { fg = color.grey, bg = 'none' },
}

-- add common lsp highlights
default = merge_tb('force', default, Lsp_highlights)

local function genModes_hl(modename, col)
  default['St_' .. modename .. 'Mode'] = { bg = 'none', fg = color[col] }
  default['St_' .. modename .. 'ModeSep'] = { fg = color[col], bg = color.grey }
end

genModes_hl('Normal', 'green')
genModes_hl('Visual', 'magenta')
genModes_hl('Insert', 'blue')
genModes_hl('Terminal', 'yellow')
genModes_hl('NTerminal', 'yellow')
genModes_hl('Replace', 'red')
genModes_hl('Confirm', 'teal')
genModes_hl('Command', 'orange')
genModes_hl('Select', 'blue')

return default
