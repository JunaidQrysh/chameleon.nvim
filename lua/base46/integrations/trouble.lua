local colors = require("base46").get_theme_tb "base_30"

return {
  TroubleCount = { fg = colors.pink },
  TroubleCode = { fg = colors.white },
  TroubleWarning = { fg = colors.orange },
  TroubleSignWarning = { link = "DiagnosticWarn" },
  TroubleTextWarning = { fg = colors.white },
  TroublePreview = { fg = colors.red },
  TroubleSource = { fg = colors.cyan },
  TroubleSignHint = { link = "DiagnosticHint" },
  TroubleTextHint = { fg = colors.white },
  TroubleHint = { fg = colors.orange },
  TroubleSignOther = { link = "DiagnosticNormal" },
  TroubleSignInformation = { fg = colors.white },
  TroubleTextInformation = { fg = colors.white },
  TroubleInformation = { fg = colors.white },
  TroubleError = { fg = colors.red },
  TroubleTextError = { fg = colors.white },
  TroubleSignError = { link = "DiagnosticError" },
  TroubleText = { fg = colors.white },
  TroubleFile = { fg = colors.yellow },
  TroubleFoldIcon = { link = "Folded" },
  TroubleNormal = { fg = colors.white },
  TroubleLocation = { fg = colors.red },
  TroubleIndent = { link = colors.Comment },
}
