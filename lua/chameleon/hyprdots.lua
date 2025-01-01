local M = {}

-- Cache frequently used values
local hyde_path = vim.fn.stdpath("data") .. "/hyde"
local hypr_conf_path = os.getenv("HOME") .. "/.config/hypr/themes/theme.conf"

-- Initialize path on module load instead of every function call
M.chameleon_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
M.hyde_theme = ""

-- Optimize file operations with local cache
local function write_to_file(path, content)
  local file = io.open(path, "w")
  if file then
    file:write(content)
    file:close()
    return true
  end
  return false
end

local function read_file(path)
  local file = io.open(path, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return content
  end
  return nil
end

function M.write_word(new)
  write_to_file(hyde_path, new)
end

function M.get_theme_from_hypr()
  local content = read_file(hypr_conf_path)
  if content then
    -- Use more efficient pattern matching
    local theme = content:match("\n?%$GTK[_%-]THEME%s*=%s*([^\n]+)")
    if theme then
      theme = theme:match("^%s*(.-)%s*$") -- More efficient trim
      M.hyde_theme = theme
      return theme
    end
    print("GTK-/_THEME Not Found in $HOME/.config/hypr/themes/theme.conf")
    return nil
  end

  print("Hyde Not Found")
  os.remove(hyde_path)
  return nil
end

function M.set_hyde()
  local hyde_theme = M.get_theme_from_hypr()
  if not hyde_theme or M.hyde_theme == "" then
    return
  end

  if hyde_theme ~= vim.g.nt then
    -- Cache theme path and use direct lookup instead of iteration
    local theme_path = M.chameleon_path .. "/colorschemes/" .. hyde_theme .. ".lua"
    local theme_file = io.open(theme_path, "r")

    if theme_file then
      theme_file:close()
      vim.g.hyde_int = true
      require("tswitch.utils").reload_theme(hyde_theme)
      M.write_word(hyde_theme)
    else
      print("Matching Theme Not Found")
    end
  elseif hyde_theme == vim.g.nt then
    if not read_file(hyde_path) then
      vim.g.hyde_int = true
      require("tswitch.utils").reload_theme(hyde_theme)
      M.write_word(hyde_theme)
    end
  end
end

function M.toggle_hyde()
  local file = io.open(hyde_path, "r")
  if file then
    file:close()
    os.remove(hyde_path)
    M.hyde_theme = ""
    print("Hyde Integration Off")
  else
    M.set_hyde()
    if M.hyde_theme ~= "" then
      print("Hyde Integration On")
    end
  end
end

return M
