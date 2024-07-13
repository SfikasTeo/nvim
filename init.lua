------------------------------------------------------------
-- Nvim Configs
------------------------------------------------------------
-- init.lua

-- Setup Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
-- Adjust the runtimepath (rtp)
vim.opt.rtp:prepend(lazypath)

-- Load lua modules
require("layouts")
require("keymaps")
require("options")
require("automation")

-- Load plugins
local plugins = require("plugins.init")
local opts = {}

require("lazy").setup(plugins, opts)

