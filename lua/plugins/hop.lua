-- lua/plugins/hop.lua
local hop = require("hop")

hop.setup({
	quit_key = "<C-c>",
})

-- keybindings based on the g-motions
local opts = { noremap = true, silent = true }

-- Maps instruction to multiple modes
local function map(modes, lhs, rhs, options)
	for i = 1, #modes do
		vim.keymap.set(modes:sub(i, i), lhs, rhs, options)
	end
end

map( "nvo", "<leader>gw", "<cmd>lua require'hop'.hint_words()<cr>", opts)
map( "nvo", "<leader>gl", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
map( "nvo", "<leader>gh", "<cmd>lua require'hop'.hint_patterns()<cr>", opts)

