-- Set up plugins

-- lua/plugins/plugins.lua
return {
  -- Color scheme OneDark
  {
      "olimorris/onedarkpro.nvim",
      priority = 1000,
      config = function()
          require('plugins.onedarkpro')
      end,
  },
  -- Telescope
  {
      'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = {'nvim-lua/plenary.nvim'},
      config = function()
          require('plugins.telescope')
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
      require('plugins.treesitter')
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
      require('plugins.neotree')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugins.lualine')
    end,
  }
}

