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
set("n", "<leader>h", "<Cmd>noh<CR>", opts)
set({"n", "v", "o"}, "<C-c>", "<Esc>", opts) -- Apply to normal, visual, and operator modes
set({"v", "o"}, "ii", "<Esc>", opts)         -- Apply to visual and operator modes
set("i", "jj", "<Esc>", opts)

-- Keep cursor in the middle of the screen
set("n", "<C-u>", "<C-u>zz", opts)
set("n", "<C-d>", "<C-d>zz", opts)

-- Delete without yanking
set({"n", "v"}, "d", '"_d', opts)
set({"n", "v"}, "x", '"_x', opts)
set({"n", "v"}, "D", '"_D', opts)

-- Add Navigating motions
set({"n", "v", "o"}, "gm", "%", opts)

-- Cut with leader + key
set({"n", "v"}, "<leader>d", "d", opts)
set({"n", "v"}, "<leader>x", "x", opts)
set({"n", "v"}, "<leader>D", "D", opts)

-- More aggressive window resizing
set("n", "<C-w><", "20<C-w><", opts)
set("n", "<C-w>-", "20<C-w>-", opts)
set("n", "<C-w>+", "20<C-w>+", opts)
set("n", "<C-w>>", "20<C-w>>", opts)

-- Terminal Mode
set("t", "ii", "<C-\\><C-n>", opts)

-- Layout switching
vim.g.keyboard_layout = "colemak-dhm"

local function layoutRemapper(layout)
    if layout == "colemak" then
        set({"n", "v", "o"}, "m", "h", opts)
        set({"n", "v", "o"}, "n", "j", opts)
        set({"n", "v", "o"}, "e", "k", opts)
        set({"n", "v", "o"}, "i", "l", opts)
        set({"n", "v", "o"}, "M", "H", opts)
        set({"n", "v", "o"}, "N", "J", opts)
        set({"n", "v", "o"}, "E", "K", opts)
        set({"n", "v", "o"}, "I", "L", opts)
        set({"n", "v", "o"}, "<C-m>", "<C-h>", opts)
        set({"n", "v", "o"}, "<C-n>", "<C-j>", opts)
        set({"n", "v", "o"}, "<C-e>", "<C-k>", opts)
        set({"n", "v", "o"}, "<C-i>", "<C-l>", opts)

        set({"n", "v", "o"}, "h", "i", opts)
        set({"n", "v", "o"}, "k", "n", opts)
        set({"n", "v", "o"}, "j", "y", opts)
        set({"n", "v", "o"}, "l", "e", opts)
        set({"n", "v", "o"}, "H", "I", opts)
        set({"n", "v", "o"}, "K", "N", opts)
        set({"n", "v", "o"}, "L", "E", opts)
        set({"n", "v", "o"}, "J", "Y", opts)
        set({"n", "v", "o"}, "<C-h>", "<C-i>", opts)
        set({"n", "v", "o"}, "<C-k>", "<C-n>", opts)
        set({"n", "v", "o"}, "<C-j>", "<C-y>", opts)
        set({"n", "v", "o"}, "<C-l>", "<C-e>", opts)

        set({"n", "v", "o"}, "j", ";", opts)
        set({"n", "v", "o"}, "J", ":", opts)
        set({"n", "v", "o"}, ":", "m", opts)
        set({"n", "v", "o"}, ";", "M", opts)

    elseif layout == "qwerty" then
        set({"n", "v", "o"}, "h", "h", opts)
        set({"n", "v", "o"}, "j", "j", opts)
        set({"n", "v", "o"}, "k", "k", opts)
        set({"n", "v", "o"}, "l", "l", opts)
        set({"n", "v", "o"}, "H", "H", opts)
        set({"n", "v", "o"}, "J", "J", opts)
        set({"n", "v", "o"}, "K", "K", opts)
        set({"n", "v", "o"}, "L", "L", opts)
        set({"n", "v", "o"}, "<C-h>", "<C-h>", opts)
        set({"n", "v", "o"}, "<C-j>", "<C-j>", opts)
        set({"n", "v", "o"}, "<C-k>", "<C-k>", opts)
        set({"n", "v", "o"}, "<C-l>", "<C-l>", opts)

        set({"n", "v", "o"}, "m", "m", opts)
        set({"n", "v", "o"}, "n", "n", opts)
        set({"n", "v", "o"}, "e", "e", opts)
        set({"n", "v", "o"}, "i", "i", opts)
        set({"n", "v", "o"}, "M", "M", opts)
        set({"n", "v", "o"}, "N", "N", opts)
        set({"n", "v", "o"}, "E", "E", opts)
        set({"n", "v", "o"}, "I", "I", opts)
        set({"n", "v", "o"}, "<C-m>", "<C-m>", opts)
        set({"n", "v", "o"}, "<C-n>", "<C-n>", opts)
        set({"n", "v", "o"}, "<C-e>", "<C-e>", opts)
        set({"n", "v", "o"}, "<C-i>", "<C-i>", opts)

        set({"n", "v", "o"}, "j", "j", opts)
    end
end

local function toggleLayout()
    if vim.g.keyboard_layout == "colemak" then
        vim.g.keyboard_layout = "qwerty"
    else
        vim.g.keyboard_layout = "colemak"
    end
    layoutRemapper(vim.g.keyboard_layout)
    vim.notify("Switched to " .. vim.g.keyboard_layout .. " layout", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ToggleLayout", toggleLayout, {})
