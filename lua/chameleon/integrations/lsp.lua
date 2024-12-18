local color = require('chameleon.colors').palette
local generate_color =
  require('chameleon.colors').change_hex_lightness
local vim_bg = require("chameleon.colorschemes." .. vim.g.nt).type

return {
  -- LSP References
  LspReferenceText = {
    bg = generate_color(color.black, vim_bg == 'dark' and 0 or 45),
    bold = true,
  },
  LspReferenceRead = {
    bg = generate_color(color.black, vim_bg == 'dark' and 0 or 45),
    bold = true,
  },
  LspReferenceWrite = {
    bg = generate_color(color.black, vim_bg == 'dark' and 0 or 45),
    bold = true,
    underline = true,
  },

  -- Lsp Diagnostics
  DiagnosticHint = { fg = color.magenta },
  DiagnosticError = { fg = color.red },
  DiagnosticWarn = { fg = color.yellow },
  DiagnosticInfo = { fg = color.blue },

  DiagnosticFloatingHint = { fg = color.magenta },
  DiagnosticFloatingError = { fg = color.red },
  DiagnosticFloatingWarn = { fg = color.yellow },
  DiagnosticFloatingInfo = { fg = color.blue },

  LspSignatureActiveParameter = {
    fg = color.green,
    italic = true,
    bold = true,
  },

  LspCodeLens = { fg = 'Grey' },
  LspCodeLensSeparator = { link = 'Boolean' },

  LspInlayHint = { fg = color.grey, italic = true },
}
