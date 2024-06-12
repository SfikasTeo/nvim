------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------
--
-- Window navigation and manipulation:
-- Using default bindings:
-- <C-w>h, <C-w>j, <C-w>k, <C-w>l -- window navigation
-- <C-w>H, <C-w>J, <C-w>K, <C-w>L -- move window
-- <C-w>s, <C-w>v -- horizontal and vertical split
-- <C-w>o -- Leave only current window
-- <C-w>c, <C-w>q -- close window

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Maps instruction to multiple modes
local function map(modes, lhs, rhs, options)
	for i = 1, #modes do
		vim.keymap.set(modes:sub(i, i), lhs, rhs, options)
	end
end

-- Unmap Space & Set it as leader
set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- quality of life:
set("n", "<leader>h", "<Cmd>noh<CR>", opts)
map("nvo", "<C-c>", "<Esc>", opts)
map("vo", "ii", "<Esc>", opts)
set("i", "jj", "<Esc>", opts)

-- Keep cursor in the middle of the screen
set("n", "<C-u>", "<C-u>zz", opts)
set("n", "<C-d>", "<C-d>zz", opts)

-- Delete without yanking
map("nv", "d", '"_d', opts)
map("nv", "x", '"_x', opts)
map("nv", "D", '"_D', opts)

-- Add Navigating motions
map("nvo", "gm", "%", opts)

-- Cut with leader + key
map("nv", "<leader>d", "d", opts)
map("nv", "<leader>x", "x", opts)
map("nv", "<leader>D", "D", opts)

-- More aggressive window resizing
set("n", "<C-w><", "20<C-w><", opts)
set("n", "<C-w>-", "20<C-w>-", opts)
set("n", "<C-w>+", "20<C-w>+", opts)
set("n", "<C-w>>", "20<C-w>>", opts)

-- Terminal Mode
set("t", "ii", "<C-\\><C-n>", opts)

