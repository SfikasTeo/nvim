-- lua/plugins/onedarkpro.lua
local onedarkpro = require("onedarkpro")

onedarkpro.setup({
	colors = {
		onedark = {
			bg = "#21252b",
		},
	},
	-- Change Options
	options = {
		cursorline = true,
		transparency = false,
		terminal_colors = true,
		lualine_transparency = false,
		highlight_inactive_windows = false,
	},
})

-- Apply the theme
onedarkpro.load()
