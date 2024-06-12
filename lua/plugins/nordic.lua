-- lua/plugins/nordic.lua

require 'nordic' .setup {
    on_palette = function(palette)
        palette.black0 = '#141412'
        palette.black1 = '#242422'
        palette.black2 = '#2f2f2d'
        palette.gray0 = '#3d3d3b'
        palette.gray1 = '#444442'
        palette.gray2 = '#525250'
        palette.gray3 = '#6d6d6b'
        palette.gray4 = '#8d8d8b'

        return palette
    end,
    bold_keywords = false,
    italic_comments = true,
    transparent_bg = false,
    bright_border = false,
    reduced_blue = true,
    swap_backgrounds = true,
    -- Override the styling of any highlight group.
    override = {},
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
