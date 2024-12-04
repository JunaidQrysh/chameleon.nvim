local M = {}

local theme_path = vim.fn.stdpath("data") .. "/theme"
local file

---@param theme string
M.change_theme = function(theme)
  require("chameleon.utils").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "NeviraideThemeReload" })
  file = io.open(theme_path, "w")
  if file then
    file:write(theme)
    file:close()
  end
end

M.choose_theme = function()
  local Menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  local menu = Menu({
    position = "50%",
    size = {
      width = 20,
      height = 12,
    },
    buf_options = { filetype = "colorschemes" },
    border = {
      padding = { 0, 1 },
      style = vim.g.b,
      text = {
        top = " Choose colorschemes ",
        top_align = "center",
        bottom = " " .. vim.g.nt .. " ",
      },
    },
    win_options = {
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },
  }, {
    lines = {
      Menu.item("Catppuccin-Mocha"),
      Menu.item("Catppuccin-Latte"),
      Menu.item("Decay-Green"),
      Menu.item("Rose-Pine"),
      Menu.item("Tokyo-Night"),
      Menu.item("Material-Sakura"),
      Menu.item("Graphite-Mono"),
      Menu.item("Cyberpunk-Edge"),
      Menu.item("Frosted-Glass"),
      Menu.item("Gruvbox-Retro"),
      Menu.item("Synth-Wave"),
      Menu.item("One-Dark"),
    },
    max_width = 30,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
    -- on_close = function() print('Menu Closed!') end,
    on_submit = function(item)
      M.change_theme(item.text)
      require("chameleon.utils").load_all_highlights()
    end,
  })

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
  menu:map("n", { "<Esc>", "q", "<C-c>" }, function()
    menu:unmount()
  end, { noremap = true, nowait = true })
  menu:map("i", { "<Esc>", "<C-q>", "<C-c>" }, function()
    menu:unmount()
  end, { noremap = true, nowait = true })
  -- mount the component
  menu:mount()
end

return M
