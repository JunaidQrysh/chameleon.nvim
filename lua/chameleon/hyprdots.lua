local M = {}

local PATHS = {
  hyde = vim.fn.stdpath "data" .. "/hyde",
  hypr_conf = os.getenv "HOME" .. "/.config/hypr/themes/theme.conf",
  hyde_status = (os.getenv "HYDE_CACHE_HOME" or os.getenv "HOME" .. "/.cache/hyde") .. "/dconf",
  base46_cache = vim.fn.stdpath "data" .. "/base46/",
}

local function read_file(path)
  local file = io.open(path, "r")
  if file then
    local content = file:read "*all"
    file:close()
    return content
  end
end

local function get_modification_time(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.mtime.sec or nil
end

local reload_attempts = 0
local MAX_ATTEMPTS = 2

local function reload_hyde()
  if reload_attempts >= MAX_ATTEMPTS then
    if vim.g.hyde_alert then
      print "Hyde Integration On"
    end
    vim.g.base46_cache = PATHS.base46_cache
    vim.g.hyde = true
    require("base46").load_all_highlights()
    M.write_modtime()
    return
  end

  reload_attempts = reload_attempts + 1
  vim.schedule(function()
    reload_hyde()
  end)
end

function M.write_modtime()
  local file = io.open(PATHS.hyde, "w")
  if file then
    file:write(tostring(get_modification_time(PATHS.hyde_status)))
    file:close()
  end
end

local function get_theme_from_hypr()
  local content = read_file(PATHS.hypr_conf)
  if not content then
    os.remove(PATHS.hyde)
    print "Hyde Not Found"
    return nil
  end

  local theme = content:match "\n?%$GTK[_%-]THEME%s*=%s*([^\n]+)"
  if not theme then
    print "GTK-THEME Not Found in $HOME/.config/hypr/themes/theme.conf"
    return nil
  end

  theme = theme:match "^%s*(.-)%s*$" -- Trim spaces

  local theme_map = {
    ["Catppuccin-Mocha"] = "catppuccin",
    ["Catppuccin-Latte"] = "catppuccin_latte",
    ["Tokyo-Night"] = "tokyonight",
    ["Rose-Pine"] = "rosepine",
    ["Material-Sakura"] = "material-lighter",
    ["Graphite-Mono"] = "monochrome",
    ["Decay-Green"] = "decay",
    ["Edge-Runner"] = "gatekeeper",
    ["Frosted-Glass"] = "github_light",
    ["Gruvbox-Retro"] = "gruvbox",
    ["Synth-Wave"] = "flouromachine",
    ["Nordic-Blue"] = "nord",
  }

  return theme_map[theme] or theme
end

function M.set_hyde()
  local hyde_theme = get_theme_from_hypr()
  if not hyde_theme then
    return
  end

  local saved_time = tonumber(read_file(PATHS.hyde) or "0")
  local current_time = get_modification_time(PATHS.hyde_status)

  if saved_time ~= current_time then
    vim.g.nt = hyde_theme
    reload_hyde()
  end
end

function M.toggle_hyde()
  if vim.fn.filereadable(PATHS.hyde) == 1 then
    os.remove(PATHS.hyde)
    print "Hyde Integration Off"
  else
    vim.g.hyde_alert = true
    M.set_hyde()
  end
end

local colors = require "base46.colors"

function M.wallbash(theme, type, th_type)
  local theme_path = os.getenv "HOME" .. "/.config/kitty/theme.conf"
  local base_color
  local theme_file = io.open(theme_path, "r")
  if theme_file then
    for line in theme_file:lines() do
      local key, value = line:match "^(%S+)%s+(%S+)$"
      if key == "background" then
        base_color = value
        theme_file:close()
        break
      end
    end
  else
    return
  end

  local r, g, b = colors.hex2rgb(base_color)
  if not r or not g or not b then
    return -- Invalid base color
  end

  -- Calculate brightness and color variance
  local brightness = (r + g + b) / 3

  -- Determine color mode
  local is_very_dark = brightness < 20
  local is_light_grey = brightness > 180

  -- Prepare the offset function based on color characteristics
  local function offset_func(delta)
    local nr, ng, nb

    if is_very_dark and delta > 0 then
      -- For dark colors, scale up positive deltas
      nr, ng, nb = r + delta * 1.5, g + delta * 1.5, b + delta * 1.5
    elseif is_light_grey and delta > 0 then
      -- For light greys, invert positive deltas
      local scale = 1.0 + (brightness - 180) / 170
      nr, ng, nb = r - delta * scale, g - delta * scale, b - delta * scale
    else
      -- Standard case
      nr, ng, nb = r + delta, g + delta, b + delta
    end

    -- Clamp values and convert to hex
    return colors.rgb2hex(
      math.max(0, math.min(255, nr)),
      math.max(0, math.min(255, ng)),
      math.max(0, math.min(255, nb))
    )
  end

  -- Create the color palette with a single pattern
  local new_palette = {
    darker_black = offset_func(-5),
    black = base_color,
    black2 = offset_func(7),
    one_bg = offset_func(15),
    one_bg2 = offset_func(25),
    one_bg3 = offset_func(35),
    grey = offset_func(45),
    grey_fg = offset_func(50),
    grey_fg2 = offset_func(55),
    light_grey = offset_func(65),
    line = offset_func(20),
    lightbg = offset_func(20),
    statusline_bg = offset_func(7),
  }

  -- Apply to the requested theme type
  local function apply(mod, var)
    for k, v in pairs(require(mod)[var]) do
      theme[k] = v
    end
  end

  if type == "base_30" or type == "base_16" then
    local mod = (th_type == "light" and not is_light_grey and "base46.themes.catppuccin")
      or (th_type == "dark" and is_light_grey and "base46.themes.catppuccin_latte")

    if mod then
      apply(mod, type)
    end

    if type == "base_30" then
      for k, v in pairs(new_palette) do
        theme[k] = v
      end
    else
      local np = new_palette
      theme.base00, theme.base01, theme.base02, theme.base03, theme.base04 =
        np.black, np.one_bg, np.one_bg3, np.grey, np.grey_fg
    end
  elseif type == "type" then
    return (th_type == "light" and not is_light_grey and "dark") or (th_type == "dark" and is_light_grey and "light")
  end
end

return M
