-- lua/plugins/luansip.lua
local ls = require("luasnip")

local set = vim.keymap.set
local opts = { silent = true }

-- Load snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Optional: Define your custom snippets here
ls.snippets = {}

-- Set up keybindings for LuaSnip
set({"i"}, "<C-K>", function() ls.expand() end, opts)
set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, opts)
set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, opts)
set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)
