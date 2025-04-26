# Chameleon.nvim

90+ colorschemes for Neovim with theme switcher, optional statusline, and [HyDE](https://github.com/HyDE-Project/HyDE) integration(automatic theme switching & wallbash).\
\
Basically this is a fork of [base46](https://github.com/NvChad/base46) made to be easily installable for non NvChad users if they just want a lot of themes with a theme switcher.\
\
NvChad's statusline is also included because base46 does not have integration for other statuslines but its disabled by default.

## Installation

```lua
{
    "JunaidQrysh/chameleon.nvim",
    dependencies = { "nvzone/volt", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
}
```

## Configuration

### Key Mappings

```lua
-- Theme switcher
vim.keymap.set("n", "<leader>th", function()
    require("tswitch").open()
end, { desc = "Theme Switcher" })

-- HyDE integration
vim.keymap.set("n", "<leader>tH", function()
    require("chameleon.hyprdots").toggle_hyde()
end, { desc = "Toggle-Hyde" })

-- Transparency toggle
vim.keymap.set("n", "<leader>tT", function()
    require("base46").toggle_transparency()
end, { desc = "Toggle Transparency" })
```

### Loading Theme

```lua
vim.b.base46_cache = vim.fn.stdpath("cache") .. "/base46/"

-- Load all highlights(integrations)
for _, file in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. file)
end

-- OR load specific highlights
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "syntax")
```

### Statusline Configuration

```lua
-- Enable statusline
opts = {
    ui = { 
        statusline = { 
            enabled = true 
        } 
    }
}
```

### Default Configuration

```lua
{
    base46 = {
        hl_add = {}, -- add custom integrations
        hl_override = {}, -- override default integrations
        integrations = {}, -- add default integrations to compile
        changed_themes = {}, -- override default themes
    },
    ui = {
        cmp = {
            show_icons_left = false, -- only for non-atom styles!
            style = "default", -- default/flat_light/flat_dark/atom/atom_colored
            format_colors = {
                tailwind = false, -- will work for css lsp too
                icon = "󱓻",
            },
        },
        telescope = { 
            style = "bordered"  -- borderless / bordered
        },
        statusline = {
            enabled = false,
            theme = "default", -- default/vscode/vscode_colored/minimal
            separator_style = "default", -- default/round/block/arrow
            -- default/round/block/arrow separators work only for default statusline theme
            -- round and block will work for minimal theme only
            order = nil,
            modules = nil,
        },
    },
}
```
See [Integrations](https://github.com/JunaidQrysh/chameleon.nvim/tree/main/lua/base46/integrations) for additional supported plugins and features.
