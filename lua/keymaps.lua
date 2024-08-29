------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

-- Notable default bindings:
-- <C-w>h, <C-w>j, <C-w>k, <C-w>l -- window navigation
-- <C-w>H, <C-w>J, <C-w>K, <C-w>L -- move window
-- <C-w>s, <C-w>v -- horizontal and vertical split
-- <C-w>o -- Leave only current window
-- <C-w>c, <C-w>q -- close window

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Unmap Space & Set it as leader
set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

set("n", "<leader>/", "<Cmd>noh<CR>", opts)
set({ "n", "v", "o" }, "<C-c>", "<Esc>", opts)
set({ "v", "o", "i" }, ",,", "<Esc>", opts)
set({ "t" }, ",,", "<C-\\><C-n>", opts)

-- Delete without yanking
set({ "n", "v" }, "d", '"_d', opts)
set({ "n", "v" }, "x", '"_x', opts)
set({ "n", "v" }, "D", '"_D', opts)

-- Add Navigating motions
set({ "n", "v", "o" }, "gm", "%", opts)
set({ "n", "v", "o" }, "<C-u>", "<C-u>zz", opts)
set({ "n", "v", "o" }, "<C-d>", "<C-d>zz", opts)

-- cut with leader + key
set({ "n", "v" }, "<leader>d", "d", opts)
set({ "n", "v" }, "<leader>x", "x", opts)
set({ "n", "v" }, "<leader>d", "d", opts)

-- more aggressive window resizing
set("n", "<c-w><", "20<c-w><", opts)
set("n", "<c-w>-", "20<c-w>-", opts)
set("n", "<c-w>+", "20<c-w>+", opts)
set("n", "<c-w>>", "20<c-w>>", opts)

-- misc
set("n", "<leader>fp", ':lua print(vim.fn.expand("%:p"))<CR>', opts)

