local M = {}

local api = vim.api
local fn = vim.fn
local uv = vim.uv
local volt = require "volt"
local ui = require "tswitch.ui"
local state = require "tswitch.state"
local reload = require("plenary.reload").reload_module

state.ns = api.nvim_create_namespace "NvThemes"

local CONFIG_THEMES_PATH = fn.stdpath "config" .. "/lua/themes"
local TRANSPARENCY_PATH = fn.stdpath "data" .. "/transparency"

local original_theme
local cached_themes

local function get_themes()
  if cached_themes then
    return cached_themes
  end

  local default_themes =
    fn.readdir(vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h") .. "/base46/themes")

  local custom_stat = uv.fs_stat(CONFIG_THEMES_PATH)
  if custom_stat and custom_stat.type == "directory" then
    local custom_themes = fn.readdir(CONFIG_THEMES_PATH)
    vim.list_extend(default_themes, custom_themes)
  end

  for i, theme in ipairs(default_themes) do
    default_themes[i] = theme:match "(.+)%..+"
  end

  cached_themes = default_themes
  return default_themes
end

function M.list_themes()
  return get_themes()
end

if not state.val then
  state.val = get_themes()
  state.themes_shown = state.val
end

local function calculate_word_padding()
  local largest = 0
  local end_idx = math.min(state.index + state.limit[state.style], #state.val)

  for i = state.index, end_idx do
    largest = math.max(largest, #state.val[i])
  end

  state.longest_name = largest
end

local function calculate_window_dims(style)
  local w = state.longest_name + state.word_gap + (#state.order * api.nvim_strwidth(state.icon)) + (state.xpad * 2)

  if style == "compact" then
    w = w + 4 -- scrollbar and padding
  elseif style == "flat" then
    w = w + 8
  end

  local h = state.limit[style] + 1
  if style == "flat" or style == "bordered" then
    local step = state.scroll_step[style]
    h = (h * step) - 5
  end

  return w, h
end

local function set_window_highlights(opts, input_win)
  if opts.border then
    api.nvim_set_hl(state.ns, "FloatBorder", { link = "Comment" })
    api.nvim_set_hl(state.ns, "Normal", { link = "Normal" })
    vim.wo[input_win].winhl = "Normal:Normal"
  else
    vim.wo[input_win].winhl = "Normal:ExBlack2Bg,FloatBorder:ExBlack2Border"
    api.nvim_set_hl(state.ns, "Normal", { link = "ExDarkBg" })
    api.nvim_set_hl(state.ns, "FloatBorder", { link = "ExDarkBorder" })
  end
end

function M.open(opts)
  opts = opts or {}

  state.buf = api.nvim_create_buf(false, true)
  state.input_buf = api.nvim_create_buf(false, true)

  original_theme = vim.g.nt
  vim.g.hyde = nil
  require("chameleon").base46.transparency = fn.filereadable(TRANSPARENCY_PATH) == 1

  state.style = opts.style or "bordered"
  state.icons.user = opts.icon
  state.icon = state.icons.user or state.icons[state.style]

  calculate_word_padding()
  local w, h = calculate_window_dims(state.style)
  state.w = w

  volt.gen_data {
    {
      buf = state.buf,
      layout = { { name = "themes", lines = ui[state.style] } },
      xpad = state.xpad,
      ns = state.ns,
    },
  }

  local row_offset = (state.style == "flat" or state.style == "bordered") and 2 or 0
  local input_row = math.floor((vim.o.lines - h) / 2) - row_offset
  local input_col = math.floor((vim.o.columns - w) / 2)

  state.input_win = api.nvim_open_win(state.input_buf, true, {
    row = input_row,
    col = input_col,
    width = w,
    height = 1,
    relative = "editor",
    style = "minimal",
    border = "single",
  })

  state.win = api.nvim_open_win(state.buf, false, {
    row = 2,
    col = -1,
    width = w,
    height = ((state.style == "flat" or state.style == "bordered") and h + 2) or h,
    relative = "win",
    style = "minimal",
    border = "single",
  })

  vim.bo[state.input_buf].buftype = "prompt"
  fn.prompt_setprompt(state.input_buf, state.prompt)

  set_window_highlights(opts, state.input_win)
  api.nvim_win_set_hl_ns(state.win, state.ns)
  api.nvim_set_current_win(state.input_win)

  local volt_opts = {
    h = (state.style == "flat" or state.style == "bordered") and (#state.val * state.scroll_step[state.style]) + 2
      or #state.val,
    w = w,
  }
  volt.run(state.buf, volt_opts)

  volt.mappings {
    bufs = { state.buf, state.input_buf },
    after_close = function()
      if not state.confirmed then
        if vim.loop.fs_stat(vim.fn.stdpath "data" .. "/hyde") ~= nil then
          vim.g.hyde = true
        end
        require("tswitch.utils").reload_theme(original_theme)
      end
      reload "tswitch"
      vim.cmd.stopinsert()
    end,
  }

  require "tswitch.mappings"

  if opts.mappings then
    opts.mappings(state.input_buf)
  end

  vim.cmd "startinsert"
end

return M
