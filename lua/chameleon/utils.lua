---@class ChameleonCore
local M = {} -- Module table for exporting functions and variables

local ntc = vim.fn.stdpath("data") .. "/neviraide_ui/"

M.chameleon_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

---Function to get the theme table (color scheme)
---@return table Theme table
M.get_theme_tb = function(type)
  -- Retrieve default theme path
  local default_dir = "chameleon.colorschemes."
  local default_path = default_dir .. vim.g.nt

  -- Attempt to load the theme
  local ok, default_theme = pcall(require, default_path)

  -- If the theme is loaded successfully, return the requested type
  if ok then
    return default_theme[type]
  else
    -- Otherwise, throw an error indicating that the theme does not exist
    error()
  end
end

---Function to merge multiple tables
---@return table
M.merge_tb = function(...)
  return vim.tbl_deep_extend("force", ...)
end

---Function to extend default highlighting with custom themes
---@param highlights table
---@param integration_name string
M.extend_default_hl = function(highlights, integration_name)
  local polish_hl = M.get_theme_tb("polish_hl")

  -- polish themes
  if polish_hl and polish_hl[integration_name] then
    highlights = M.merge_tb(highlights, polish_hl[integration_name])
  end

  return highlights
end

---Function to load highlighting settings for a specific group
---@param group string Name of the highlighting group
---@return table
M.load_highlight = function(group)
  local highlights = require("chameleon.integrations." .. group)
  return M.extend_default_hl(highlights, group)
end

---Function to convert a table into a Lua code string
---@param tb table Table to convert
---@return string
M.table_to_str = function(tb)
  local result = ""

  for hlgroupName, hlgroup_vals in pairs(tb) do
    local hlname = "'" .. hlgroupName .. "',"
    local opts = ""

    for optName, optVal in pairs(hlgroup_vals) do
      local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
        or '"' .. optVal .. '"'
      opts = opts .. optName .. "=" .. valueInStr .. ","
    end

    result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. opts .. "})"
  end

  return result
end

---Function to save Lua code string to a cache file
---@param filename string Name of the cache file
---@param tb table Table to serialize and save
M.saveStr_to_cache = function(filename, tb)
  local bg_opt = "vim.opt.bg='" .. M.get_theme_tb("type") .. "'"
  local borders = "vim.g.b='" .. M.get_theme_tb("borders") .. "'"
  local defaults_cond = filename == "defaults" and bg_opt and borders or ""

  local lines = "return string.dump(function()" .. defaults_cond .. M.table_to_str(tb) .. "end, true)"
  local file = io.open(ntc .. filename, "wb")

  if file then
    file:write(loadstring(lines)())
    file:close()
  end
end

---Function to compile all highlighting settings into cache files
M.compile = function()
  if not vim.uv.fs_stat(ntc) then
    vim.fn.mkdir(ntc, "p")
  end

  -- All integration modules, each file returns a table
  local hl_files = M.chameleon_path .. "/integrations"

  for _, file in ipairs(vim.fn.readdir(hl_files)) do
    local filename = vim.fn.fnamemodify(file, ":r")
    M.saveStr_to_cache(filename, M.load_highlight(filename))
  end
end

---Function to load all highlighting settings from cache files
M.load_all_highlights = function()
  require("plenary.reload").reload_module("chameleon")
  M.compile()

  for _, file in ipairs(vim.fn.readdir(ntc)) do
    dofile(ntc .. file)
  end
end

M.ToggleHyde = function()
  local theme_path = vim.fn.stdpath("data") .. "/theme"
  local file = io.open(theme_path, "r")
  if file then
    file:close()
    os.remove(theme_path)
    M.load_all_highlights()
  else
    local new_file = io.open(theme_path, "w")
    if new_file then
      new_file:write(vim.g.nt)
      new_file:close()
    end
  end
end

return M
