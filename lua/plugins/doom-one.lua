-- lua/plugins/doom-one.lua

vim.g.doom_one_cursor_coloring = true
vim.g.doom_one_terminal_colors = true
vim.g.doom_one_italic_comments = true
vim.g.doom_one_enable_treesitter = true
vim.g.doom_one_diagnostics_text_color = true
vim.g.doom_one_transparent_background = false
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20
vim.g.doom_one_plugin_neorg = false
vim.g.doom_one_plugin_barbar = false
vim.g.doom_one_plugin_telescope = true
vim.g.doom_one_plugin_neogit = true
vim.g.doom_one_plugin_nvim_tree = false
vim.g.doom_one_plugin_dashboard = false
vim.g.doom_one_plugin_startify = false
vim.g.doom_one_plugin_whichkey = false
vim.g.doom_one_plugin_indent_blankline = false
vim.g.doom_one_plugin_vim_illuminate = false
vim.g.doom_one_plugin_lspsaga = false

-- Apply the colorscheme
vim.cmd("colorscheme doom-one")

{
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("plugins.doom-one")
    end,
}

