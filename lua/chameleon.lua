local M = {}

local file = io.open(vim.fn.stdpath("data") .. "/theme", "r")
if file then
  M.hyde = false
  vim.g.nt = file:read("*a")
  file:close()
else
  M.hyde = true
  vim.g.nt = require("chameleon.hyprdots").get_theme_from_hypr() or "Tokyo-Night"
  local file_path = require("chameleon.utils").chameleon_path .. "/colorschemes/" .. vim.g.nt .. ".lua"
  local file1 = io.open(file_path, "r")
  if file1 then
    file1:close()
  else
    vim.g.nt = "Tokyo-Night"
  end
end

function M.setup()
  vim.g.b = require("chameleon.utils").get_theme_tb("borders")
  require("which-key").add({
    {
      "<leader>sC",
      function()
        require("chameleon.nui").choose_theme()
      end,
      desc = "Colorscheme",
    },
    {
      "<leader>sT",
      function()
        require("chameleon.utils").ToggleHyde()
      end,
      desc = "Toggle-Hyde",
    },
  })
  require("chameleon.utils").load_all_highlights()
end

return M
