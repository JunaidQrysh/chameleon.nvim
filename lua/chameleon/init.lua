local M = {}

M.base46 = {
  hl_add = {},
  hl_override = {},
  integrations = {},
  changed_themes = {},
  transparency = false,
}

M.ui = {
  cmp = {
    icons_left = false,
    style = "default",
    format_colors = {
      tailwind = false,
      icon = "󱓻",
    },
  },
  telescope = { style = "bordered" },
  statusline = {
    enabled = false,
    theme = "default",
    separator_style = "default",
    order = nil,
    modules = nil,
  },
}

-- Setup function to modify M directly
function M.setup(config)
  -- Deep merge config into M, modifying M directly
  M.base46 = vim.tbl_deep_extend("force", M.base46, config.base46 or {})
  M.ui = vim.tbl_deep_extend("force", M.ui, config.ui or {})
end

return M
