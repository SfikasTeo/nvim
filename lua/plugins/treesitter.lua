-- lua/plugins/treesitter.lua
require'nvim-treesitter.configs'.setup {
  -- Parsers to install:
  ensure_installed = {
    -- Assembly
    'asm', 'disassembly',
    -- Linux
    'devicetree', 'bash', 'jq',
    'make', 'pem', 'strace',
    -- Programming
    'c', 'cpp', 'cuda', 'cmake',
    'go', 'lua', 'java', 'nix',
    'python', 'rust', 'zig',
    -- Programming adjacent
    'json', 'csv',
    -- Web
    'css', 'html', 'javascript',
    'scss', 'typescript', 'xml',
    -- Configuration files
    'ini', 'dockerfile', 'rasi',
    'yaml', 'toml',
    -- Other
    'comment', 'diff',
    'git_config', 'git_rebase',
    'gitcommit', 'gitignore',
    -- Notes
    'markdown', 'markdown_inline',
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true, -- Tree-sitter highlighting
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },

  autopairs = {
    enable = true
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "vv",
      node_incremental = "vv",
      node_decremental = "vu",
      scope_incremental = false,
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      selection_modes = {},
      keymaps = {
        ["if"] = "@function.inner",     -- Select around function
        ["af"] = "@function.outer",     -- Select inside function
        ["iC"] = "@class.inner",        -- Select inside Class
        ["aC"] = "@class.outer",        -- Select whole Class
        ["ib"] = "@block.inner",        -- Select around block
        ["ab"] = "@block.outer",        -- Select inside block
        ["ic"] = "@conditional.inner",  -- Select inside conditional
        ["ac"] = "@conditional.outer",  -- Select around conditional
        ["il"] = "@loop.inner",         -- Select inside loop
        ["al"] = "@loop.outer",         -- Select around loop
        ["aa"] = "@assignment.outer",   -- Select assignment
        ["as"] = "@statement.outer",    -- Select Statement
      },
    },
    lsp_interop = {
      enable = true,
      border = {
        {"╭", "FloatBorder"}, {"─", "FloatBorder"},
        {"╮", "FloatBorder"}, {"│", "FloatBorder"},
        {"╯", "FloatBorder"}, {"─", "FloatBorder"},
        {"╰", "FloatBorder"}, {"│", "FloatBorder"}
      },
      floating_preview_opts = {},
    },
  },
}

