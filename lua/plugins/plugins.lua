-- Set up plugins

-- lua/plugins/plugins.lua
return {
	-- Color scheme OneDark
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		config = function()
			require("plugins.onedarkpro")
		end,
	},
	--
	-- Core Utilities
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	-- Tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("plugins.treesitter")
		end,
	},
	-- Neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.neotree")
		end,
	},
	-- lua-line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins.lualine")
		end,
	},
	-- autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	},
    -- Floating Terminal
    {
        "devkvlt/floaty.nvim",
        config = function()
            require("plugins.floaty")
        end,
    },
	--
	-- LSPs - Formatters - Linters - DAPs
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.mason")
		end,
	},
	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugins.mason-lspconfig")
		end,
	},
	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lspconfig")
		end,
	},
	-- none-ls
	{
		"nvimtools/none-ls.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.none-ls")
		end,
	},
	--
	-- Completions
	-- nvim-cmp
	{
		-- Completion Engine
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- Connects cmp to LSP
			"hrsh7th/cmp-nvim-lsp",
			{
				-- Snipset Engine
				"L3MON4D3/LuaSnip",
				dependencies = {
					-- Connects cmp with sources
					"saadparwaiz1/cmp_luasnip",
					-- Snipset Provider
					"rafamadriz/friendly-snippets",
				},
			},
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	},
	--
	-- Code Completion
	-- Github Copilot
	{
		"github/copilot.vim",
		config = function() end,
	},
	--
	-- Git Integration
	-- Git Signs
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	},
}
