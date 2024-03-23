------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

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
map("nvoi", ",,", "<Esc>", opts)
set("i", "jj", "<Esc>", opts)

-- Keep cursor in the middle of the screen
set("n", "<C-u>", "<C-u>zz", opts)
set("n", "<C-d>", "<C-d>zz", opts)

-- Delete without yanking
map("nv", "d", '"_d', opts)
map("nv", "x", '"_x', opts)
map("nv", "D", '"_D', opts)

-- Add Navigating motions with g+helm
map("nvo", "gh", "0", opts)
map("nvo", "gl", "$", opts)

-- Navigation to leader + g-me
map("nvo", "gm", "%", opts)

-- Cut with leader + key
map("nv", "<leader>d", "d", opts)
map("nv", "<leader>x", "x", opts)
map("nv", "<leader>D", "D", opts)

-- Move around split windows with C-<hjkl>
set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-l>", "<C-w>l", opts)

-- Resize split windows with leader + C-<hjkl>
set("n", "<leader><C-h>", "10<C-w><", opts)
set("n", "<leader><C-j>", "10<C-w>-", opts)
set("n", "<leader><C-k>", "10<C-w>+", opts)
set("n", "<leader><C-l>", "10<C-w>>", opts)

-- Split a terminal
map("nvo", "<C-w><C-v>", ":40vsplit | terminal<CR>", opts)
map("nvo", "<C-w><C-s>", ":20split | terminal<CR>", opts)

-- Terminal Mode
set("t", ",,", "<C-\\><C-n>", opts)

