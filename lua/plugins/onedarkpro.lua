-- lua/plugins/onedarkpro.lua
local onedarkpro = require('onedarkpro')

onedarkpro.setup{
  colors = {
    onedark = {
      bg = '#21252b',
    },
  },
  -- Change Options
  options = {
    cursorline = true,                   -- Use cursorline highlighting?
    transparency = false,                -- Use a transparent background?
    terminal_colors = true,              -- Use the theme's colors for Neovim's :terminal?
    lualine_transparency = false,        -- Center bar transparency?
    highlight_inactive_windows = false,  -- When the window is out of focus, change the normal background?
  }
}

-- Apply the theme
onedarkpro.load()
