-- lua/plugins/leap.lua
local leap = require("leap")

-- Set the backdrop highlight group to 'Comment'
vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#7f848e" })

-- 's' for local bidirectional search
vim.keymap.set({ "n", "x", "o" }, "s", function()
	leap.leap({ target_windows = { vim.fn.win_getid() } })
end, { silent = true })

-- 'S' for global bidirectional search
vim.keymap.set({ "n", "x", "o" }, "S", leap.leap, { silent = true })

