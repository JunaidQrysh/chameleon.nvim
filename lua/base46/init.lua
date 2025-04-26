local M = {}
local opts = require("chameleon").base46
local cache_path = vim.g.base46_cache
local statusline = "vim.o.statusline = '%!v:lua.require(\"chameleon.statusline."
  .. require("chameleon").ui.statusline.theme
  .. "\")()' "
  .. 'require("chameleon.statusline.utils").autocmds()'

local integrations = {
  "blankline",
  "blink",
  "cmp",
  "defaults",
  "devicons",
  "git",
  "lsp",
  "mason",
  "statusline",
  "syntax",
  "treesitter",
  "telescope",
  "whichkey",
}

for _, value in ipairs(opts.integrations) do
  table.insert(integrations, value)
end

M.get_theme_tb = function(type)
  local present1, default_theme = pcall(require, "base46.themes." .. vim.g.nt)
  local present2, user_theme = pcall(require, "themes." .. vim.g.nt)
  local theme

  if present1 then
    theme = default_theme[type]
  elseif present2 then
    theme = user_theme[type]
  else
    error "No such theme!"
  end
  if vim.g.hyde then
    local th_type = default_theme.type
    th_type = require("chameleon.hyprdots").wallbash(theme, type, th_type)
    if th_type then
      theme = th_type
    end
  end
  return theme
end

M.merge_tb = function(...)
  return vim.tbl_deep_extend("force", ...)
end

local lighten = require("base46.colors").change_hex_lightness
local mixcolors = require("base46.colors").mix

-- turns color var names in hl_override/hl_add to actual colors
-- hl_add = { abc = { bg = "one_bg" }} -> bg = colors.one_bg
M.turn_str_to_color = function(tb)
  local colors = vim.tbl_extend("force", M.get_theme_tb "base_30", M.get_theme_tb "base_16")
  local copy = vim.deepcopy(tb)

  for _, hlgroups in pairs(copy) do
    for opt, val in pairs(hlgroups) do
      local valtype = type(val)

      if opt == "fg" or opt == "bg" or opt == "sp" then
        -- named colors from base30
        if valtype == "string" and val:sub(1, 1) ~= "#" and val ~= "none" and val ~= "NONE" then
          hlgroups[opt] = colors[val]
        elseif valtype == "table" then
          -- transform table to color
          hlgroups[opt] = #val == 2 and lighten(colors[val[1]], val[2])
            or mixcolors(colors[val[1]], colors[val[2]], val[3])
        end
      end
    end
  end

  return copy
end

M.extend_default_hl = function(highlights, integration_name)
  local polish_hl = M.get_theme_tb "polish_hl"

  -- polish themes
  if polish_hl and polish_hl[integration_name] then
    highlights = M.merge_tb(highlights, polish_hl[integration_name])
  end

  -- transparency
  if opts.transparency then
    local glassy = require "base46.glassy"

    for key, value in pairs(glassy) do
      if highlights[key] then
        highlights[key] = M.merge_tb(highlights[key], value)
      end
    end
  end

  local hl_override = opts.hl_override
  local overriden_hl = M.turn_str_to_color(hl_override)

  for key, value in pairs(overriden_hl) do
    if highlights[key] then
      highlights[key] = M.merge_tb(highlights[key], value)
    end
  end

  return highlights
end

M.get_integration = function(name)
  local highlights = require("base46.integrations." .. name)
  return M.extend_default_hl(highlights, name)
end

-- convert table into string
M.tb_2str = function(tb)
  local result = ""

  for hlgroupName, v in pairs(tb) do
    local hlname = "'" .. hlgroupName .. "',"
    local hlopts = ""

    for optName, optVal in pairs(v) do
      local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
        or '"' .. optVal .. '"'
      hlopts = hlopts .. optName .. "=" .. valueInStr .. ","
    end

    result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. hlopts .. "})"
  end

  return result
end

M.str_to_cache = function(filename, str)
  -- Thanks to https://github.com/nullchilly and https://github.com/EdenEast/nightfox.nvim
  -- It helped me understand string.dump stuff
  local lines = "return string.dump(function()" .. str .. "end, true)"
  local file = io.open(cache_path .. filename, "wb")

  if file then
    file:write(loadstring(lines)())
    file:close()
  end
end

M.compile = function()
  if not vim.uv.fs_stat(cache_path) then
    vim.fn.mkdir(cache_path, "p")
  end

  local term = string.format("vim.g.nt='%s' %s", vim.g.nt, require "base46.term")
  if require("chameleon").ui.statusline.enabled then
    term = string.format("%s %s", statusline, term)
    vim.api.nvim_clear_autocmds {
      event = "LspProgress",
      pattern = { "begin", "report", "end" },
    }
    vim.o.statusline = "%!v:lua.require('chameleon.statusline." .. require("chameleon").ui.statusline.theme .. "')()"
    require("chameleon.statusline.utils").autocmds()
  end

  M.str_to_cache("term", term)
  M.str_to_cache("colors", require "base46.color_vars")

  for _, name in ipairs(integrations) do
    local hl_str = M.tb_2str(M.get_integration(name))

    if name == "defaults" then
      hl_str = "vim.o.bg='" .. M.get_theme_tb "type" .. "' " .. hl_str
    end

    M.str_to_cache(name, hl_str)
  end
end

M.load_all_highlights = function()
  require("plenary.reload").reload_module "base46"
  M.compile()

  for _, name in ipairs(integrations) do
    dofile(cache_path .. name)
  end

  -- update blankline
  pcall(function()
    require("ibl").update()
  end)

  vim.api.nvim_exec_autocmds("User", { pattern = "NvThemeReload" })
end

M.override_theme = function(default_theme, theme_name)
  local changed_themes = opts.changed_themes
  return M.merge_tb(default_theme, changed_themes.all or {}, changed_themes[theme_name] or {})
end

M.toggle_transparency = function()
  if vim.fn.filereadable(vim.fn.stdpath "data" .. "/transparency") == 1 then
    opts.transparency = false
    os.remove(vim.fn.stdpath "data" .. "/transparency")
  else
    opts.transparency = true
    vim.fn.writefile({}, vim.fn.stdpath "data" .. "/transparency")
  end
  M.load_all_highlights()
end

return M
