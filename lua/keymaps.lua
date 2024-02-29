------------------------------------------------------------
-- Keyboard Mappings
------------------------------------------------------------

-- Set Custom Keymaps
local set = vim.keymap.set
local default_set = { noremap = true, silent = true }
local allow_remap = { noremap = false, silent = true }

-- Maps instruction to multiple modes
local function map(modes, lhs, rhs, opts)
    for i = 1, #modes do
        vim.keymap.set(modes:sub(i,i), lhs, rhs, opts)
    end
end

-- Unmap Space & Set it as leader
set('n', '<Space>', '<Nop>', default_set)
vim.g.mapleader = ' '

-- quality of life:
set('n', '<Space>', '<Cmd>noh<CR>', default_set)
map('nvoi',',,', '<Esc>', default_set)
set('i', 'jj', '<Esc>', default_set)

-- Keep cursor in the middle of the screen
set('n', '<C-u>', '<C-u>zz', default_set)
set('n', '<C-d>', '<C-d>zz', default_set)

-- Delete without yanking
map('nv', 'd', '"_d', default_set)
map('nv', 'x', '"_x', default_set)
map('nv', 'D', '"_D', default_set)

-- Add Navigating motions with g+helm
map('nvo', 'gh', '0', default_set)
map('nvo', 'ge', 'G', default_set)
map('nvo', 'gl', '$', default_set)
map('nvo', 'gm', '%', default_set)

-- Cut with leader + key
map('nv', '<leader>d', 'd', default_set)
map('nv', '<leader>x', 'x', default_set)
map('nv', '<leader>D', 'D', default_set)

-- Move around split windows with leader + hjkl
set('n', '<C-h>', '<C-w>h', default_set)
set('n', '<C-j>', '<C-w>j', default_set)
set('n', '<C-k>', '<C-w>k', default_set)
set('n', '<C-l>', '<C-w>l', default_set)

-- Resize windows with leader + r followed by hjkl
set('n', '<leader><C-h>', '10<C-w><', default_set)
set('n', '<leader><C-j>', '10<C-w>-', default_set)
set('n', '<leader><C-k>', '10<C-w>+', default_set)
set('n', '<leader><C-l>', '10<C-w>>', default_set)

-- Split a terminal
map('nvo', '<leader><C-v>', ':40vsplit | terminal<CR>', default_set)
map('nvo', '<leader><C-s>', ':20split | terminal<CR>', default_set)

-- Terminal Mode
set('t', ',,', '<C-\\><C-n>', default_set)

