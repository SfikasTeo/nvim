-- lua/plugins/nordic.lua

require 'nordic' .setup {
    on_palette = function(palette)
        palette.black0 = '#101010'
        palette.black1 = '#141414'
        palette.black2 = '#181818'
        palette.gray0 = '#1c1c1a'
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
        VisualNOS = { bg = '#424242'},
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

