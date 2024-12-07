local M = {}

M.palette = {}

local theme_path = os.getenv("HOME") .. "/.config/kitty/theme.conf"

M.colors = {
  kitty = {},
}

local function extract_kitty_colors()
  local theme_file = io.open(theme_path, "r")
  if not theme_file then
    print("Failed to open file: " .. theme_path)
  end

  if theme_file then
    for line in theme_file:lines() do
      local color_name, color_value = line:match("^([%w%-_]+)%s+#([%da-fA-F]+)")
      if color_name and color_value then
        if color_name == "active_tab_background" then
          color_name = "tab_background"
        end
        M.colors.kitty[color_name] = "#" .. color_value
      end
    end
  end

  if theme_file then
    theme_file:close()
  end
end

if require("chameleon").config.hyde then
extract_kitty_colors()
end

local function set_colors()
  ---@type table
  local theme_colors = require("chameleon.utils").get_theme_tb("colors")
  local kitty_colors = M.colors.kitty

  if require("chameleon").config.hyde then
    -- combine theme_colors and kitty_colors
    for key, value in pairs(theme_colors) do
      if kitty_colors[key] ~= nil then
        M.palette[key] = kitty_colors[key]
      else
        M.palette[key] = value
      end
    end

    -- add from kitty_colors, if not exist in theme_colors
    for key, value in pairs(kitty_colors) do
      if theme_colors[key] == nil then
        M.palette[key] = value
      end
    end
  else
    M.palette = theme_colors
  end
end
set_colors()

---Convert a hex color value to RGB
---@param hex? string: The hex color value
---@return integer r: Red (0-255)
---@return integer g: Green (0-255)
---@return integer b: Blue (0-255)
M.hex2rgb = function(hex)
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)
  return r, g, b
end

---Convert an RGB color value to hex
---@param r integer Red (0-255)
---@param g integer Green (0-255)
---@param b integer Blue (0-255)
---@return string HEX The hexadecimal string representation of the color
M.rgb2hex = function(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Helper function to convert a HSL color value to RGB
-- Not to be used directly, use M.hsl2rgb instead
local hsl2rgb_helper = function(p, q, a)
  if a < 0 then
    a = a + 6
  end
  if a >= 6 then
    a = a - 6
  end
  if a < 1 then
    return (q - p) * a + p
  elseif a < 3 then
    return q
  elseif a < 4 then
    return (q - p) * (4 - a) + p
  else
    return p
  end
end

-- Convert a HSL color value to RGB
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @return r: Red (0-255)
-- @return g: Green (0-255)
-- @return b: Blue (0-255)
M.hsl2rgb = function(h, s, l)
  local t1, t2, r, g, b

  h = h / 60
  if l <= 0.5 then
    t2 = l * (s + 1)
  else
    t2 = l + s - (l * s)
  end

  t1 = l * 2 - t2
  r = hsl2rgb_helper(t1, t2, h + 2) * 255
  g = hsl2rgb_helper(t1, t2, h) * 255
  b = hsl2rgb_helper(t1, t2, h - 2) * 255

  return r, g, b
end

-- Convert an RGB color value to HSL
-- @param r Red (0-255)
-- @param g Green (0-255)
-- @param b Blue (0-255)
-- @return h Hue (0-360)
-- @return s Saturation (0-1)
-- @return l Lightness (0-1)
M.rgb2hsl = function(r, g, b)
  local min, max, l, s, maxcolor, h
  r, g, b = r / 255, g / 255, b / 255

  min = math.min(r, g, b)
  max = math.max(r, g, b)
  maxcolor = 1 + (max == b and 2 or (max == g and 1 or 0))

  if maxcolor == 1 then
    h = (g - b) / (max - min)
  elseif maxcolor == 2 then
    h = 2 + (b - r) / (max - min)
  elseif maxcolor == 3 then
    h = 4 + (r - g) / (max - min)
  end

  if not rawequal(type(h), "number") then
    h = 0
  end

  h = h * 60

  if h < 0 then
    h = h + 360
  end

  l = (min + max) / 2

  if min == max then
    s = 0
  else
    if l < 0.5 then
      s = (max - min) / (max + min)
    else
      s = (max - min) / (2 - max - min)
    end
  end

  return h, s, l
end

-- Convert a hex color value to HSL
-- @param hex: The hex color value
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
M.hex2hsl = function(hex)
  local r, g, b = M.hex2rgb(hex)
  return M.rgb2hsl(r, g, b)
end

-- Convert a HSL color value to hex
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @returns hex color value
M.hsl2hex = function(h, s, l)
  local r, g, b = M.hsl2rgb(h, s, l)
  return M.rgb2hex(r, g, b)
end

-- Change the hue of a color by a given amount
-- @param hex The hex color value
-- @param amount The amount to change the hue.
--               Negative values decrease the hue, positive values increase it.
-- @return The hex color value
M.change_hex_hue = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  h = h + (percent / 100)
  if h > 360 then
    h = 360
  end
  if h < 0 then
    h = 0
  end
  return M.hsl2hex(h, s, l)
end

-- Desaturate or saturate a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to desaturate or saturate the color.
--                Negative values desaturate the color, positive values saturate it
-- @return The hex color value
M.change_hex_saturation = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  s = s + (percent / 100)
  if s > 1 then
    s = 1
  end
  if s < 0 then
    s = 0
  end
  return M.hsl2hex(h, s, l)
end

---Lighten or darken a color by a given percentage.
---Negative values darken the color, positive values lighten it.
---@param hex string The hex color value.
---@param percent integer The percentage to lighten or darken the color.
---@return string HEX The hex color value.
M.change_hex_lightness = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  l = l + (percent / 100)
  if l > 1 then
    l = 1
  end
  if l < 0 then
    l = 0
  end
  return M.hsl2hex(h, s, l)
end

-- Compute a gradient between two colors
-- @param hex1 The first hex color value
-- @param hex2 The second hex color value
-- @param steps The number of steps to compute
-- @return A table of hex color values
M.compute_gradient = function(hex1, hex2, steps)
  local r1, g1, b1 = M.hex2rgb(hex1)
  local r2, g2, b2 = M.hex2rgb(hex2)
  local gradients = {}

  for i = 0, steps - 1 do
    local r = r1 + math.floor((r2 - r1) * i / (steps - 1))
    local g = g1 + math.floor((g2 - g1) * i / (steps - 1))
    local b = b1 + math.floor((b2 - b1) * i / (steps - 1))
    gradients[i + 1] = M.rgb2hex(r, g, b)
  end

  return gradients
end

return M
