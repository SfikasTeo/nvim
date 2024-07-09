-- lua/plugins/nordic.lua

local sidebar_bg = '#1a1a1a'

require 'nordic' .setup {
    on_palette = function(palette)
        palette.black0 = '#101010'
        palette.black1 = '#141414'
        palette.black2 = '#161616'
        palette.gray0 = '#1e1e1e'
        palette.gray1 = '#424242'
        palette.gray2 = '#525252'
        palette.gray3 = '#626262'
        palette.gray4 = '#727272'
        return palette
    end,
    bold_keywords = false,
    italic_comments = true,
    transparent_bg = false,
    bright_border = false,
    reduced_blue = true,
    swap_backgrounds = false,
    -- Override the styling of any highlight group.
    override = {
        Visual = { bg = '#424242' },
        VisualNOS = { bg = '#424242' },
        CursorLine = { bg = '#161616' },
        NvimTreeCursorLine = { bg = '#242424' },
        NvimTreeNormal = { bg = sidebar_bg },
        NvimTreeNormalNC = { bg = sidebar_bg },
    },
    cursorline = {
        bold = false,
        bold_number = true,
        theme = 'dark',
        blend = 0.85,
    },
    noice = {
        style = 'classic',
    },
    telescope = {
        style = 'classic',
    },
    leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
    },
    ts_context = {
        dark_background = true,
    }
}

vim.cmd.colorscheme 'nordic'

