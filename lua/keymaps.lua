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

-- Unmap Space & Set it as leader
set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Quality of life:
set("n", "<leader>/", "<Cmd>noh<CR>", opts)
set({ "n", "v", "o" }, "<C-c>", "<Esc>", opts)
set({ "v", "o" }, "ii", "<Esc>", opts)
set("i", "jj", "<Esc>", opts)

-- Delete without yanking
set({ "n", "v" }, "d", '"_d', opts)
set({ "n", "v" }, "x", '"_x', opts)
set({ "n", "v" }, "D", '"_D', opts)

-- Add Navigating motions
set({ "n", "v", "o" }, "gm", "%", opts)
set({ "n", "v", "o" }, "<C-u>", "<C-u>zz", opts)
set({ "n", "v", "o" }, "<C-d>", "<C-d>zz", opts)
set({ "n", "v", "o" }, "<C-j>", "4j", opts)
set({ "n", "v", "o" }, "<C-k>", "4k", opts)

-- Cut with leader + key
set({ "n", "v" }, "<leader>d", "d", opts)
set({ "n", "v" }, "<leader>x", "x", opts)
set({ "n", "v" }, "<leader>D", "D", opts)

-- More aggressive window resizing
set("n", "<C-w><", "20<C-w><", opts)
set("n", "<C-w>-", "20<C-w>-", opts)
set("n", "<C-w>+", "20<C-w>+", opts)
set("n", "<C-w>>", "20<C-w>>", opts)

-- Terminal Mode
set("t", "ii", "<C-\\><C-n>", opts)

-- layout switching
vim.g.keyboard_layout = "qwerty"

local function clearMappings()
	set({ "n", "v", "o" }, "n", "n", opts)
	set({ "n", "v", "o" }, "e", "e", opts)
	set({ "n", "v", "o" }, "j", "j", opts)
	set({ "n", "v", "o" }, "k", "k", opts)
	set({ "n", "v", "o" }, "<c-n>", "<c-n>", opts)
	set({ "n", "v", "o" }, "<c-e>", "<c-e>", opts)
	set({ "n", "v", "o" }, "<c-w>j", "<c-w>j", opts)
	set({ "n", "v", "o" }, "<c-w>k", "<c-w>k", opts)
    set({ "n", "v", "o" }, "<leader>j", "<leader>j", opts)
    set({ "n", "v", "o" }, "<leader>k", "<leader>k", opts)

	set({ "i" }, "nn", "nn", opts)
end

local function layoutMapper(layout)
	if layout == "colemak" then
		set({ "n", "v", "o" }, "n", "j", opts)
		set({ "n", "v", "o" }, "e", "k", opts)
		set({ "n", "v", "o" }, "<c-n>", "8j", opts)
		set({ "n", "v", "o" }, "<c-e>", "8k", opts)
		set({ "n", "v", "o" }, "<c-w>n", "<c-w>j", opts)
		set({ "n", "v", "o" }, "<c-w>e", "<c-w>k", opts)
		set({ "n", "v", "o" }, "<leader>n", "<leader>j", opts)
		set({ "n", "v", "o" }, "<leader>e", "<leader>k", opts)

		set({ "n", "v", "o" }, "j", "e", opts)
		set({ "n", "v", "o" }, "k", "n", opts)
		set({ "n", "v", "o" }, "<c-w>j", "<c-w>e", opts)
		set({ "n", "v", "o" }, "<c-w>k", "<c-w>n", opts)
		set({ "n", "v", "o" }, "<leader>j", "<leader>e", opts)
		set({ "n", "v", "o" }, "<leader>k", "<leader>n", opts)

		set({ "i" }, "nn", "<esc>", opts)
	elseif layout ~= "colemak" then
		clearMappings()
	end
end

local function toggleLayout()
	if vim.g.keyboard_layout == "colemak" then
		vim.g.keyboard_layout = "reset"
		vim.notify("resetting to default layout", vim.log.levels.info)
	else
		vim.g.keyboard_layout = "colemak"
		vim.notify("switching to colemak layout", vim.log.levels.info)
	end
	layoutMapper(vim.g.keyboard_layout)
end

vim.api.nvim_create_user_command("ToggleLayout", toggleLayout, {})

