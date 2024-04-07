-- lua/plugins/leap.lua
local leap = require("leap")

-- 's' for local bidirectional search
vim.keymap.set({ "n", "x", "o" }, "s", function()
	leap.leap({ target_windows = { vim.fn.win_getid() } })
end, { silent = true })

-- 'S' for global bidirectional search
vim.keymap.set({ "n", "x", "o" }, "S", leap.leap, { silent = true })

