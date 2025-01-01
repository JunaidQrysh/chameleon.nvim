# Chameleon.nvim

A comprehensive collection of 80+ colorschemes for Neovim featuring dynamic theme switching, statusline customization, and [HyDE](https://github.com/prasanthrangan/hyprdots) integration.

*Credits: [RAprogramm](https://github.com/RAprogramm)* for HyDE integration and [base46](https://github.com/NvChad/base46) for all the themes.

## Installation

```lua
{
    "JunaidQrysh/chameleon.nvim",
    dependencies = { "nvzone/volt" },
    event = "VeryLazy",
}
```

## Features
- 80+ built-in colorschemes
- Dynamic theme switching
- Statusline customization
- HyDE support
- Transparency toggle
- Completion menu styling

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

### Loading Highlights

```lua
-- Load all highlights
vim.b.base46_cache = vim.fn.stdpath("cache") .. "/base46/"
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

-- HyDE-specific configuration
-- Requires: ttf-nonicons-bin-git (AUR)
-- Add to kitty.conf: symbol_map U+f101-U+f25c nonicons
vim.g.nonicons = true
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

---

[![Catppuccin-Mocha](https://placehold.co/130x30/b4befe/11111b?text=Catppuccin-Mocha&font=Oswald)](#-Catppuccin-Mocha)
[![Catppuccin-Latte](https://placehold.co/130x30/dd7878/eff1f5?text=Catppuccin-Latte&font=Oswald)](#-Catppuccin-Latte)
[![Decay-Green](https://placehold.co/130x30/90ceaa/151720?text=Decay-Green&font=Oswald)](#-Decay-Green)
[![Rosé-Pine](https://placehold.co/130x30/c4a7e7/191724?text=Rosé-Pine&font=Oswald)](#-Rosé-Pine)
[![Tokyo-Night](https://placehold.co/130x30/7aa2f7/24283b?text=Tokyo-Night&font=Oswald)](#-Tokyo-Night)<br>
[![Material-Sakura](https://placehold.co/130x30/f2e9e1/b4637a?text=Material-Sakura&font=Oswald)](#-Material-Sakura)
[![Graphite-Mono](https://placehold.co/130x30/a6a6a6/262626?text=Graphite-Mono&font=Oswald)](#-Graphite-Mono)
[![Cyberpunk-Edge](https://placehold.co/130x30/fada16/000000?text=Cyberpunk-Edge&font=Oswald)](#-Cyberpunk-Edge)
[![Frosted-Glass](https://placehold.co/130x30/7ed6ff/1e4c84?text=Frosted-Glass&font=Oswald)](#-Frosted-Glass)
[![Gruvbox-Retro](https://placehold.co/130x30/475437/B5CC97?text=Gruvbox-Retro&font=Oswald)](#-Gruvbox-Retro)
[![Synth-Wave](https://placehold.co/130x30/ff7edb/241B2F?text=Synth-Wave&font=Oswald)](#-Synth-Wave)
[![One-Dark](https://placehold.co/130x30/98c379/241B2F?text=One-Dark&font=Oswald)](#-One-Dark)

</div><br><table><td><br>

> #### **_<div align = right>// Catppuccin-Mocha</div>_**
>
> ![Catppuccin-Mocha#1](./.screenshots/catppuccin-mocha.png) <br><br>

<hr>

> #### **_<div align = right>// Catppuccin-Latte</div>_**
>
> ![Catppuccin-Latte#1](./.screenshots/catppuccin-latte.png)<br><br>

<hr>

> #### **_<div align = right>// Decay-Green</div>_**
>
> ![Decay-Green#1](./.screenshots/decay-green.png)<br><br>

<hr>

> #### **_<div align = right>// Rosé-Pine</div>_**
>
> ![Rosé-Pine#1](./.screenshots/rose-pine.png)<br><br>

<hr>

> #### **_<div align = right>// Tokyo-Night</div>_**
>
> ![Tokyo-Night#1](./.screenshots/tokyo-night.png)<br><br>

<hr>

> #### **_<div align = right>// Material-Sakura</div>_**
>
> ![Material-Sakura#1](./.screenshots/material-sacura.png)<br><br>

<hr>

> #### **_<div align = right>// Graphite-Mono</div>_**
>
> ![Graphite-Mono#1](./.screenshots/graphite-mono.png)<br><br>

<hr>

> #### **_<div align = right>// Cyberpunk-Edge</div>_**
>
> ![Edge-Runner#1](./.screenshots/cyberpunk-edge.png)<br><br>

<hr>

> #### **_<div align = right>// Frosted-Glass</div>_**
>
> ![Frosted-Glass#1](./.screenshots/frosted-glass.png)<br><br>

<hr>

> #### **_<div align = right>// Gruvbox-Retro</div>_**
>
> ![Gruvbox-Retro#1](./.screenshots/gruvbox-retro.png)

<hr>

> #### **_<div align = right>// Synth-Wave</div>_**
>
> ![Synth-Wave#1](./.screenshots/synth-wave.png)

<hr>

> #### **_<div align = right>// One-Dark</div>_**
>
> ![One-Dark#1](./.screenshots/one-dark.png)

<hr>

</td></table>

</div>
